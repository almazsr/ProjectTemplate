try {
    Push-Location ..
	
	$projectDirectory=Get-Location
	
	$nugetPackagesDirectory="$ENV:UserProfile\.nuget\packages"	
	
	$reportGeneratorExe="$nugetPackagesDirectory\reportgenerator\4.6.4\tools\net47\ReportGenerator.exe"	
	$openCoverExe="$nugetPackagesDirectory\opencover\4.7.922\tools\OpenCover.Console.exe"
	$altCoverExe="$nugetPackagesDirectory\altcover\7.1.782\tools\net45\AltCover.exe"	
	$dotnetExe="C:\Program Files\dotnet\dotnet.exe"
	$coverageDirectory="$projectDirectory\coverage"
	$coverageDirectoryXPlat="$coverageDirectory\xplat"
	$coverageReportDirectory="$coverageDirectory\report"
	$fullFwTestsDll="$projectDirectory\test\ProjectTemplate.Tests.NetFramework\bin\Debug\ProjectTemplate.Tests.NetFramework.dll"
	$nugetExe="$projectDirectory\build\nuget.exe"
		
	"Build XPlat solution"
	
	dotnet build "$projectDirectory\src\ProjectTemplate.sln"
	
	"Restore FullFw solution"
	
	& $nugetExe restore "$projectDirectory\src\ProjectTemplate.NetFramework.sln"
	
	"Build FullFw solution"
	
	dotnet build "$projectDirectory\src\ProjectTemplate.NetFramework.sln"	

	"Run and calculate cover of XPlat tests"
	
	if (Test-Path $coverageDirectoryXPlat) {
		Remove-Item $coverageDirectoryXPlat -Recurse
	}
	
	dotnet test "$projectDirectory\test\ProjectTemplate.Tests" --collect:"XPlat Code Coverage" -r $coverageDirectoryXPlat
	
	Get-ChildItem $coverageDirectoryXPlat -Filter "*coverage.cobertura.xml" -Recurse | ForEach {$coverageInput = $coverageInput + "`"" + $_.Directory + "\" + $_ + "`" ";}
	
	"Restore FullFw tests solution"
	
	& $nugetExe restore "$projectDirectory\test\ProjectTemplate.Tests.NetFramework.sln"
	
	"Build FullFw tests solution"	
	
	dotnet build "$projectDirectory\test\ProjectTemplate.Tests.NetFramework.sln"
	
	"Run and calculate cover of FullFw tests"
	
	try {	
		Push-Location $coverageDirectory
		& $openCoverExe -register:user -target:$dotnetExe -targetargs:"test $fullFwTestsDll" -output:fullfw.coverage.xml -filter:"+[*]* -[*.Tests*]*"
		& $reportGeneratorExe "-reports:$coverageInput;fullfw.coverage.xml" "-targetdir:$coverageReportDirectory"
	}
	finally {
		Pop-Location
	}	
}
catch {	
	exit 1
}
finally {
    Pop-Location
}