jar:file://<HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-sbt/main_2.12/1.8.0/main_2.12-1.8.0-sources.jar!/sbt/internal/graph/model.scala
### jar%3Afile%3A%2F%2F%2Froot%2F.cache%2Fcoursier%2Fv1%2Fhttps%2Frepo1.maven.org%2Fmaven2%2Forg%2Fscala-sbt%2Fmain_2.12%2F1.8.0%2Fmain_2.12-1.8.0-sources.jar%21%2Fsbt%2Finternal%2Fgraph%2Fmodel.scala:15: error: ; expected but package found
package internal
^

occurred in the presentation compiler.

action parameters:
uri: jar:file://<HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-sbt/main_2.12/1.8.0/main_2.12-1.8.0-sources.jar!/sbt/internal/graph/model.scala
text:
```scala
import _root_.scala.xml.{TopScope=>$scope}
import _root_.sbt._
import _root_.sbt.Keys._
import _root_.sbt.nio.Keys._
import _root_.sbt.ScriptedPlugin.autoImport._, _root_.sbt.plugins.JUnitXmlReportPlugin.autoImport._, _root_.sbt.plugins.MiniDependencyTreePlugin.autoImport._, _root_.bloop.integrations.sbt.BloopPlugin.autoImport._
import _root_.sbt.plugins.IvyPlugin, _root_.sbt.plugins.JvmPlugin, _root_.sbt.plugins.CorePlugin, _root_.sbt.ScriptedPlugin, _root_.sbt.plugins.SbtPlugin, _root_.sbt.plugins.SemanticdbPlugin, _root_.sbt.plugins.JUnitXmlReportPlugin, _root_.sbt.plugins.Giter8TemplatePlugin, _root_.sbt.plugins.MiniDependencyTreePlugin, _root_.bloop.integrations.sbt.BloopPlugin
/*
 * sbt
 * Copyright 2011 - 2018, Lightbend, Inc.
 * Copyright 2008 - 2010, Mark Harrah
 * Licensed under Apache License 2.0 (see LICENSE)
 */

package sbt
package internal
package graph

import java.io.File
import sjsonnew._
import scala.collection.mutable.{ HashMap, MultiMap, Set }

private[sbt] case class GraphModuleId(organization: String, name: String, version: String) {
  def idString: String = organization + ":" + name + ":" + version
}

private[sbt] object GraphModuleId {
  import sjsonnew.BasicJsonProtocol.StringJsonFormat
  implicit val graphModuleIdIso = LList.iso[GraphModuleId, String :*: String :*: String :*: LNil](
    { m: GraphModuleId =>
      ("organization", m.organization) :*: ("name", m.name) :*: ("version", m.version) :*: LNil
    }, {
      case (_, organization) :*: (_, name) :*: (_, version) :*: LNil =>
        GraphModuleId(organization, name, version)
    }
  )
}

private[sbt] case class Module(
    id: GraphModuleId,
    license: Option[String] = None,
    extraInfo: String = "",
    evictedByVersion: Option[String] = None,
    jarFile: Option[File] = None,
    error: Option[String] = None
) {
  def hadError: Boolean = error.isDefined
  def isUsed: Boolean = !isEvicted
  def isEvicted: Boolean = evictedByVersion.isDefined
}

private[sbt] object Module {
  import sjsonnew.BasicJsonProtocol._
  implicit val moduleIso = LList.iso[Module, GraphModuleId :*: Option[String] :*: String :*: Option[
    String
  ] :*: Option[File] :*: Option[String] :*: LNil](
    { m: Module =>
      ("id", m.id) :*: ("license", m.license) :*: ("extraInfo", m.extraInfo) :*:
        ("evictedByVersion", m.evictedByVersion) :*: (
        "jarFile",
        m.jarFile
      ) :*: ("error", m.error) :*: LNil
    }, {
      case (_, id) :*: (_, license) :*: (_, extraInfo) :*: (_, evictedByVersion) :*: (_, jarFile) :*: (
            _,
            error
          ) :*: LNil =>
        Module(id, license, extraInfo, evictedByVersion, jarFile, error)
    }
  )
}

private[sbt] case class ModuleGraph(nodes: Seq[Module], edges: Seq[Edge]) {
  lazy val modules: Map[GraphModuleId, Module] =
    nodes.map(n => (n.id, n)).toMap

  def module(id: GraphModuleId): Option[Module] = modules.get(id)

  lazy val dependencyMap: Map[GraphModuleId, Seq[Module]] =
    createMap(identity)

  lazy val reverseDependencyMap: Map[GraphModuleId, Seq[Module]] =
    createMap { case (a, b) => (b, a) }

  def createMap(
      bindingFor: ((GraphModuleId, GraphModuleId)) => (GraphModuleId, GraphModuleId)
  ): Map[GraphModuleId, Seq[Module]] = {
    val m = new HashMap[GraphModuleId, Set[Module]] with MultiMap[GraphModuleId, Module]
    edges.foreach { entry =>
      val (f, t) = bindingFor(entry)
      module(t).foreach(m.addBinding(f, _))
    }
    m.toMap.mapValues(_.toSeq.sortBy(_.id.idString)).toMap.withDefaultValue(Nil)
  }

  def roots: Seq[Module] =
    nodes.filter(n => !edges.exists(_._2 == n.id)).sortBy(_.id.idString)
}

private[sbt] object ModuleGraph {
  val empty = ModuleGraph(Seq.empty, Seq.empty)

  import BasicJsonProtocol._
  implicit val moduleGraphIso = LList.iso[ModuleGraph, Vector[Module] :*: Vector[Edge] :*: LNil](
    { g: ModuleGraph =>
      ("nodes", g.nodes.toVector) :*: ("edges", g.edges.toVector) :*: LNil
    }, {
      case (_, nodes: Vector[Module]) :*: (_, edges: Vector[Edge]) :*: LNil =>
        ModuleGraph(nodes, edges)
    }
  )
}

```



#### Error stacktrace:

```
scala.meta.internal.parsers.Reporter.syntaxError(Reporter.scala:16)
	scala.meta.internal.parsers.Reporter.syntaxError$(Reporter.scala:16)
	scala.meta.internal.parsers.Reporter$$anon$1.syntaxError(Reporter.scala:22)
	scala.meta.internal.parsers.Reporter.syntaxError(Reporter.scala:17)
	scala.meta.internal.parsers.Reporter.syntaxError$(Reporter.scala:17)
	scala.meta.internal.parsers.Reporter$$anon$1.syntaxError(Reporter.scala:22)
	scala.meta.internal.parsers.ScalametaParser.syntaxErrorExpected(ScalametaParser.scala:421)
	scala.meta.internal.parsers.ScalametaParser.expect(ScalametaParser.scala:423)
	scala.meta.internal.parsers.ScalametaParser.accept(ScalametaParser.scala:427)
	scala.meta.internal.parsers.ScalametaParser.acceptStatSep(ScalametaParser.scala:447)
	scala.meta.internal.parsers.ScalametaParser.acceptStatSepOpt(ScalametaParser.scala:451)
	scala.meta.internal.parsers.ScalametaParser.statSeqBuf(ScalametaParser.scala:4462)
	scala.meta.internal.parsers.ScalametaParser.$anonfun$batchSource$13(ScalametaParser.scala:4696)
	scala.Option.getOrElse(Option.scala:201)
	scala.meta.internal.parsers.ScalametaParser.$anonfun$batchSource$1(ScalametaParser.scala:4696)
	scala.meta.internal.parsers.ScalametaParser.atPos(ScalametaParser.scala:319)
	scala.meta.internal.parsers.ScalametaParser.autoPos(ScalametaParser.scala:365)
	scala.meta.internal.parsers.ScalametaParser.batchSource(ScalametaParser.scala:4652)
	scala.meta.internal.parsers.ScalametaParser.$anonfun$source$1(ScalametaParser.scala:4645)
	scala.meta.internal.parsers.ScalametaParser.atPos(ScalametaParser.scala:319)
	scala.meta.internal.parsers.ScalametaParser.autoPos(ScalametaParser.scala:365)
	scala.meta.internal.parsers.ScalametaParser.source(ScalametaParser.scala:4645)
	scala.meta.internal.parsers.ScalametaParser.entrypointSource(ScalametaParser.scala:4650)
	scala.meta.internal.parsers.ScalametaParser.parseSourceImpl(ScalametaParser.scala:135)
	scala.meta.internal.parsers.ScalametaParser.$anonfun$parseSource$1(ScalametaParser.scala:132)
	scala.meta.internal.parsers.ScalametaParser.parseRuleAfterBOF(ScalametaParser.scala:59)
	scala.meta.internal.parsers.ScalametaParser.parseRule(ScalametaParser.scala:54)
	scala.meta.internal.parsers.ScalametaParser.parseSource(ScalametaParser.scala:132)
	scala.meta.parsers.Parse$.$anonfun$parseSource$1(Parse.scala:29)
	scala.meta.parsers.Parse$$anon$1.apply(Parse.scala:36)
	scala.meta.parsers.Api$XtensionParseDialectInput.parse(Api.scala:25)
	scala.meta.internal.semanticdb.scalac.ParseOps$XtensionCompilationUnitSource.toSource(ParseOps.scala:17)
	scala.meta.internal.semanticdb.scalac.TextDocumentOps$XtensionCompilationUnitDocument.toTextDocument(TextDocumentOps.scala:206)
	scala.meta.internal.pc.SemanticdbTextDocumentProvider.textDocument(SemanticdbTextDocumentProvider.scala:54)
	scala.meta.internal.pc.ScalaPresentationCompiler.$anonfun$semanticdbTextDocument$1(ScalaPresentationCompiler.scala:356)
```
#### Short summary: 

jar%3Afile%3A%2F%2F%2Froot%2F.cache%2Fcoursier%2Fv1%2Fhttps%2Frepo1.maven.org%2Fmaven2%2Forg%2Fscala-sbt%2Fmain_2.12%2F1.8.0%2Fmain_2.12-1.8.0-sources.jar%21%2Fsbt%2Finternal%2Fgraph%2Fmodel.scala:15: error: ; expected but package found
package internal
^