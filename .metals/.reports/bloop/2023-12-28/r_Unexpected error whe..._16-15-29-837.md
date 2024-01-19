error id: AdiGTTPlJKTiYnxjWvQ1Nw==
### Bloop error:

Unexpected error when compiling root: sbt.internal.inc.InvalidComponent: Couldn't retrieve module org.scala-sbt:compiler-bridge_2.13:1.9.5:compile
	at sbt.internal.inc.BloopComponentCompiler.$anonfun$compileAndInstall$2(BloopComponentCompiler.scala:276)
	at sbt.internal.inc.BloopComponentCompiler.$anonfun$compileAndInstall$2$adapted(BloopComponentCompiler.scala:257)
	at sbt.io.IO$.withTemporaryDirectory(IO.scala:488)
	at sbt.io.IO$.withTemporaryDirectory(IO.scala:498)
	at sbt.internal.inc.BloopComponentCompiler.$anonfun$compileAndInstall$1(BloopComponentCompiler.scala:257)
	at sbt.internal.inc.BloopComponentCompiler.$anonfun$compileAndInstall$1$adapted(BloopComponentCompiler.scala:255)
	at sbt.io.IO$.withTemporaryDirectory(IO.scala:488)
	at sbt.io.IO$.withTemporaryDirectory(IO.scala:498)
	at sbt.internal.inc.BloopComponentCompiler.compileAndInstall(BloopComponentCompiler.scala:255)
	at sbt.internal.inc.BloopComponentCompiler.$anonfun$compiledBridgeJar$1(BloopComponentCompiler.scala:245)
	at sbt.internal.inc.IfMissing$Define.run(IfMissing.scala:19)
	at sbt.internal.inc.BloopComponentManager.createAndCache$1(BloopComponentManager.scala:46)
	at sbt.internal.inc.BloopComponentManager.$anonfun$files$3(BloopComponentManager.scala:60)
	at sbt.internal.inc.BloopComponentManager.getOrElse$1(BloopComponentManager.scala:38)
	at sbt.internal.inc.BloopComponentManager.$anonfun$files$2(BloopComponentManager.scala:60)
	at sbt.internal.inc.BloopComponentManager$$anon$2.call(BloopComponentManager.scala:89)
	at bloop.ComponentLock.apply(BloopComponentsLock.scala:10)
	at bloop.ComponentLock.apply$(BloopComponentsLock.scala:9)
	at bloop.BloopComponentsLock$.apply(BloopComponentsLock.scala:14)
	at sbt.internal.inc.BloopComponentManager.lock(BloopComponentManager.scala:89)
	at sbt.internal.inc.BloopComponentManager.$anonfun$lockSecondaryCache$1(BloopComponentManager.scala:84)
	at scala.Option.map(Option.scala:230)
	at sbt.internal.inc.BloopComponentManager.lockSecondaryCache(BloopComponentManager.scala:84)
	at sbt.internal.inc.BloopComponentManager.fromSecondary$1(BloopComponentManager.scala:58)
	at sbt.internal.inc.BloopComponentManager.$anonfun$files$6(BloopComponentManager.scala:64)
	at sbt.internal.inc.BloopComponentManager.getOrElse$1(BloopComponentManager.scala:38)
	at sbt.internal.inc.BloopComponentManager.$anonfun$files$5(BloopComponentManager.scala:64)
	at sbt.internal.inc.BloopComponentManager$$anon$2.call(BloopComponentManager.scala:89)
	at bloop.ComponentLock.apply(BloopComponentsLock.scala:10)
	at bloop.ComponentLock.apply$(BloopComponentsLock.scala:9)
	at bloop.BloopComponentsLock$.apply(BloopComponentsLock.scala:14)
	at sbt.internal.inc.BloopComponentManager.lock(BloopComponentManager.scala:89)
	at sbt.internal.inc.BloopComponentManager.lockLocalCache(BloopComponentManager.scala:82)
	at sbt.internal.inc.BloopComponentManager.files(BloopComponentManager.scala:64)
	at sbt.internal.inc.BloopComponentManager.file(BloopComponentManager.scala:72)
	at sbt.internal.inc.BloopComponentCompiler.compiledBridgeJar(BloopComponentCompiler.scala:245)
	at sbt.internal.inc.BloopComponentCompiler$BloopCompilerBridgeProvider.compiledBridge(BloopComponentCompiler.scala:123)
	at sbt.internal.inc.BloopComponentCompiler$BloopCompilerBridgeProvider.fetchCompiledBridge(BloopComponentCompiler.scala:129)
	at sbt.internal.inc.AnalyzingCompiler.getDualLoader(AnalyzingCompiler.scala:354)
	at sbt.internal.inc.AnalyzingCompiler.getCompilerLoader(AnalyzingCompiler.scala:343)
	at sbt.internal.inc.AnalyzingCompiler.compile(AnalyzingCompiler.scala:87)
	at sbt.internal.inc.bloop.internal.BloopHighLevelCompiler.compileSources$1(BloopHighLevelCompiler.scala:133)
	at sbt.internal.inc.bloop.internal.BloopHighLevelCompiler.$anonfun$compile$7(BloopHighLevelCompiler.scala:159)
	at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
	at sbt.internal.inc.bloop.internal.BloopHighLevelCompiler.$anonfun$compile$1(BloopHighLevelCompiler.scala:71)
	at bloop.tracing.NoopTracer$.trace(BraveTracer.scala:53)
	at sbt.internal.inc.bloop.internal.BloopHighLevelCompiler.timed$1(BloopHighLevelCompiler.scala:70)
	at sbt.internal.inc.bloop.internal.BloopHighLevelCompiler.$anonfun$compile$6(BloopHighLevelCompiler.scala:159)
	at scala.runtime.java8.JFunction0$mcV$sp.apply(JFunction0$mcV$sp.java:23)
	at monix.eval.internal.TaskRunLoop$.startFull(TaskRunLoop.scala:81)
	at monix.eval.internal.TaskRestartCallback.syncOnSuccess(TaskRestartCallback.scala:101)
	at monix.eval.internal.TaskRestartCallback.onSuccess(TaskRestartCallback.scala:74)
	at monix.eval.internal.TaskExecuteOn$AsyncRegister$$anon$1.run(TaskExecuteOn.scala:71)
	at java.base/java.util.concurrent.ForkJoinTask$RunnableExecuteAction.exec(ForkJoinTask.java:1395)
	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:373)
	at java.base/java.util.concurrent.ForkJoinPool$WorkQueue.topLevelExec(ForkJoinPool.java:1182)
	at java.base/java.util.concurrent.ForkJoinPool.scan(ForkJoinPool.java:1655)
	at java.base/java.util.concurrent.ForkJoinPool.runWorker(ForkJoinPool.java:1622)
	at java.base/java.util.concurrent.ForkJoinWorkerThread.run(ForkJoinWorkerThread.java:165)
Caused by: coursierapi.error.SimpleResolutionError$1: Error downloading org.scala-sbt:compiler-bridge_2.13:1.9.5
  download error: Caught java.net.ConnectException (Connection refused) while downloading https://maven.aliyun.com/repository/central/org/scala-sbt/compiler-bridge_2.13/1.9.5/compiler-bridge_2.13-1.9.5.pom
  download error: Caught java.net.ConnectException (Connection refused) while downloading https://maven.aliyun.com/repository/public/org/scala-sbt/compiler-bridge_2.13/1.9.5/compiler-bridge_2.13-1.9.5.pom
  download error: Caught java.net.ConnectException (Connection refused) while downloading https://maven.aliyun.com/mvn/view/org/scala-sbt/compiler-bridge_2.13/1.9.5/compiler-bridge_2.13-1.9.5.pom
  download error: Caught java.net.ConnectException (Connection refused) while downloading https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.9.5/compiler-bridge_2.13-1.9.5.pom
  download error: Caught java.net.ConnectException (Connection refused) while downloading https://repo.huaweicloud.com/repository/maven/org/scala-sbt/compiler-bridge_2.13/1.9.5/compiler-bridge_2.13-1.9.5.pom
  download error: Caught java.net.ConnectException (Connection refused) while downloading https://scala-ci.typesafe.com/artifactory/scala-integration/org/scala-sbt/compiler-bridge_2.13/1.9.5/compiler-bridge_2.13-1.9.5.pom
	at coursierapi.error.SimpleResolutionError.of(SimpleResolutionError.java:11)
	at coursierapi.shaded.coursier.internal.api.ApiHelper$.simpleResError(ApiHelper.scala:371)
	at coursierapi.shaded.coursier.internal.api.ApiHelper$.doFetch(ApiHelper.scala:415)
	at coursierapi.shaded.coursier.internal.api.ApiHelper.doFetch(ApiHelper.scala)
	at coursierapi.Fetch.fetchResult(Fetch.java:244)
	at coursierapi.Fetch.fetch(Fetch.java:239)
	at bloop.DependencyResolution$.resolveDependenciesWithErrors(DependencyResolution.scala:90)
	at bloop.DependencyResolution$.resolveWithErrors(DependencyResolution.scala:65)
	at sbt.internal.inc.BloopComponentCompiler.$anonfun$compileAndInstall$2(BloopComponentCompiler.scala:267)
	... 58 more

#### Short summary: 

Unexpected error when compiling root: sbt.internal.inc.InvalidComponent: Couldn't retrieve module or...