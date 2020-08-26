try {
    Push-Location ..
	
	$projectDirectory=Get-Location
	
	$nugetPackagesDirectory="$ENV:UserProfile\.nuget\packages"	
	
	$reportGeneratorExe="$nugetPackagesDirectory\reportgenerator\4.6.4\tools\net47\ReportGenerator.exe"	
	$openCoverExe="$nugetPackagesDirectory\opencover\4.7.922\tools\OpenCover.Console.exe"
	$altCoverExe="$nugetPackagesDirectory\altcover\7.1.782\tools\net45\AltCover.exe"	
	$dotnetExe="C:\Program Files\dotnet\dotnet.exe"
	$coverageDirectory="$projectDirectory\coverage"
	$coverageDirectoryTestResults="$coverageDirectory\TestResults"
	$coverageReportDirectory="$coverageDirectory\report"
	$fullFwTestsDll="$projectDirectory\test\ProjectTemplate.Tests.NetFramework\bin\Debug\ProjectTemplate.Tests.NetFramework.dll"
		
	"Build XPlat solution"
	
	dotnet build "$projectDirectory\src\ProjectTemplate.sln"
	
	"Build FullFw solution"
	
	dotnet build "$projectDirectory\src\ProjectTemplate.NetFramework.sln"	

	"Run and calculate cover of XPlat tests"
	
	Remove-Item $coverageDirectoryTestResults -Recurse
	
	dotnet test "$projectDirectory\test\ProjectTemplate.Tests" --collect:"XPlat Code Coverage" -r $coverageDirectoryTestResults
	
	Get-ChildItem $coverageDirectoryTestResults -Filter "*coverage.cobertura.xml" -Recurse | ForEach {$coverageInput = $coverageInput + "`"" + $_.Directory + "\" + $_ + "`" ";}
	
	"Run and calculate cover of FullFw tests"
	
	try {
		Push-Location $coverageDirectory
		& $openCoverExe -register:user -target:$dotnetExe -targetargs:"test $fullFwTestsDll" -output:coverage.opencover.xml -filter:"+[*]* -[*.Tests*]*"
		& $reportGeneratorExe "-reports:$coverageInput;coverage.opencover.xml" "-targetdir:$coverageReportDirectory"
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