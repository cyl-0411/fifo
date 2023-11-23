jar:file://<HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.12.17/scala-library-2.12.17-sources.jar!/scala/collection/generic/BitOperations.scala
### jar%3Afile%3A%2F%2F%2Froot%2F.cache%2Fcoursier%2Fv1%2Fhttps%2Frepo1.maven.org%2Fmaven2%2Forg%2Fscala-lang%2Fscala-library%2F2.12.17%2Fscala-library-2.12.17-sources.jar%21%2Fscala%2Fcollection%2Fgeneric%2FBitOperations.scala:20: error: ; expected but package found
package collection
^

occurred in the presentation compiler.

action parameters:
uri: jar:file://<HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.12.17/scala-library-2.12.17-sources.jar!/scala/collection/generic/BitOperations.scala
text:
```scala
import _root_.scala.xml.{TopScope=>$scope}
import _root_.sbt._
import _root_.sbt.Keys._
import _root_.sbt.nio.Keys._
import _root_.sbt.ScriptedPlugin.autoImport._, _root_.sbt.plugins.JUnitXmlReportPlugin.autoImport._, _root_.sbt.plugins.MiniDependencyTreePlugin.autoImport._, _root_.bloop.integrations.sbt.BloopPlugin.autoImport._
import _root_.sbt.plugins.IvyPlugin, _root_.sbt.plugins.JvmPlugin, _root_.sbt.plugins.CorePlugin, _root_.sbt.ScriptedPlugin, _root_.sbt.plugins.SbtPlugin, _root_.sbt.plugins.SemanticdbPlugin, _root_.sbt.plugins.JUnitXmlReportPlugin, _root_.sbt.plugins.Giter8TemplatePlugin, _root_.sbt.plugins.MiniDependencyTreePlugin, _root_.bloop.integrations.sbt.BloopPlugin
/*
 * Scala (https://www.scala-lang.org)
 *
 * Copyright EPFL and Lightbend, Inc.
 *
 * Licensed under Apache License 2.0
 * (http://www.apache.org/licenses/LICENSE-2.0).
 *
 * See the NOTICE file distributed with this work for
 * additional information regarding copyright ownership.
 */

package scala
package collection
package generic

/** Some bit operations.
 *
 *  See [[http://www.drmaciver.com/2008/08/unsigned-comparison-in-javascala/]] for
 *  an explanation of unsignedCompare.
 */
private[collection] object BitOperations {
  trait Int {
    type Int = scala.Int
    def zero(i: Int, mask: Int)                 = (i & mask) == 0
    def mask(i: Int, mask: Int)                 = i & (complement(mask - 1) ^ mask)
    def hasMatch(key: Int, prefix: Int, m: Int) = mask(key, m) == prefix
    def unsignedCompare(i: Int, j: Int)         = (i < j) ^ (i < 0) ^ (j < 0)
    def shorter(m1: Int, m2: Int)               = unsignedCompare(m2, m1)
    def complement(i: Int)                      = (-1) ^ i
    def bits(num: Int)                          = 31 to 0 by -1 map (i => (num >>> i & 1) != 0)
    def bitString(num: Int, sep: String = "")   = bits(num) map (b => if (b) "1" else "0") mkString sep
    def highestOneBit(j: Int)                   = java.lang.Integer.highestOneBit(j)
  }
  object Int extends Int

  trait Long {
    type Long = scala.Long
    def zero(i: Long, mask: Long)                  = (i & mask) == 0L
    def mask(i: Long, mask: Long)                  = i & (complement(mask - 1) ^ mask)
    def hasMatch(key: Long, prefix: Long, m: Long) = mask(key, m) == prefix
    def unsignedCompare(i: Long, j: Long)          = (i < j) ^ (i < 0L) ^ (j < 0L)
    def shorter(m1: Long, m2: Long)                = unsignedCompare(m2, m1)
    def complement(i: Long)                        = (-1L) ^ i
    def bits(num: Long)                            = 63L to 0L by -1L map (i => (num >>> i & 1L) != 0L)
    def bitString(num: Long, sep: String = "")     = bits(num) map (b => if (b) "1" else "0") mkString sep
    def highestOneBit(j: Long)                     = java.lang.Long.highestOneBit(j)
  }
  object Long extends Long
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

jar%3Afile%3A%2F%2F%2Froot%2F.cache%2Fcoursier%2Fv1%2Fhttps%2Frepo1.maven.org%2Fmaven2%2Forg%2Fscala-lang%2Fscala-library%2F2.12.17%2Fscala-library-2.12.17-sources.jar%21%2Fscala%2Fcollection%2Fgeneric%2FBitOperations.scala:20: error: ; expected but package found
package collection
^