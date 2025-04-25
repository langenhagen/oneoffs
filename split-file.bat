rem Split srcFile itno several chunks.

@echo off
setlocal
set "srcFile=cues.m4b"
set "destDir=."
set "baseName=bigfile_chunk"
set "chunkSize=400MB"
powershell -NoProfile -Command ^
  "$srcFile='%srcFile%';" ^
  "$destDir='%destDir%';" ^
  "$baseName='%baseName%';" ^
  "$chunkSize=%chunkSize%;" ^
  "$fs=[System.IO.File]::OpenRead($srcFile);" ^
  "$i=0;" ^
  "while($fs.Position -lt $fs.Length) {" ^
  "  $bs=[Math]::Min($chunkSize, $fs.Length - $fs.Position);" ^
  "  $buffer=New-Object byte[] $bs;" ^
  "  $fs.Read($buffer,0,$bs)|Out-Null;" ^
  "  [System.IO.File]::WriteAllBytes((Join-Path $destDir (\"{0}_{1}.part\" -f $baseName,$i)),$buffer);" ^
  "  $i++;" ^
  "};" ^
  "$fs.Close();"
endlocal