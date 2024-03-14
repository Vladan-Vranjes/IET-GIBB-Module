Function Get-Folder($initialDirectory="")
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

#Pfade bestimmen
$FolderPath = Get-Folder
$DrivePath = Get-Folder
$CsvPath = "G:\My Drive" + "\Ausgabe.csv"

#textdatei in endpfad erstellen um bei leerem ordner eine Fehlermeldung zu verhindern + datei als versteckt anzeigen lassen
New-Item "$DrivePath\test.txt" -Force
Set-Content "$DrivePath\test.txt" 'Dieses Dokument wurde erstellt, falls dieser Ordner leer war, damit Fehlermeldungen verhindert werden.'
$FILE=Get-Item "$DrivePath\test.txt" -Force
$FILE.attributes='Hidden'


#die zwei pfade vergleichen und das ergebnis als csv ausgeben
$Vergleich = Compare-Object (Get-ChildItem $FolderPath)(Get-ChildItem $DrivePath)
$Vergleich | Export-Csv -Path $CsvPath -Force

#Csv auslesen
$A = Import-Csv -Path $CsvPath
$Datei = $A.InputObject
$Seite = $A.SideIndicator
$CSVFILE=Get-Item "$CsvPath" -Force
$CSVFILE.attributes='Hidden'

#liste erstellen
$Nichtgebackupt = @()

#Mit einer schleife identifizieren welche dateien nicht gebackupt sind
$I = 0
$Anzahl = ($A.InputObject).Count

While ($I -lt $anzahl) {
    if ($A.SideIndicator[$I] -eq "<=") {
        $Nichtgebackupt = $Nichtgebackupt + $A.InputObject[$I]
    }
    $I = $I +1
}

#dateien backupen die es nicht sind
$Anzahl_nichtgebackupt = $Nichtgebackupt.Count
$I = 0
While($I -lt $Anzahl_Nichtgebackupt){
$Path = $FolderPath + "\" + $Nichtgebackupt[$I]
Copy-Item -Path $Path -Destination $DrivePath -Force
$I = $I +1
}

#ueberprüfen ob die Dateien erfolgreich gebackupt wurden 
$I = 0
$Destinationpath = $DrivePath + "\" + $Nichtgebackupt[$I]
$TestBackup = Test-Path $Destinationpath
While ($I -lt $Anzahl_Nichtgebackupt) {
if ($TestBackup = "True") {
    $msg = $msg + "
    " + $Nichtgebackupt[$I] + "wurde erfolgreich gebackupt"
    }

else{
    $msg = $msg + "
    " + $Nichtgebackupt[$I]  + "wurde verloren"
    }

$I = $I + 1
}

# rueckmeldung an host

[System.Windows.Forms.MessageBox]::Show($msg, "Backup",0)

$msg = $null