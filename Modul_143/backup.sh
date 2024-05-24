#!/bin/bash
 
# Definiere Pfade für Quell- und Zielverzeichnisse
SOURCE_DIR="vmadmin@192.168.220.13:~/data"
BACKUP_DIR="/home/vmadmin/backup"
 
# Ermittle den Wochentag (1 für Montag, 2 für Dienstag, ..., 7 für Sonntag)
current_weekday=$(date +%u)
 
# Ermittle den Tag im Jahr
current_day=$(date +%j) # Tag des Jahres (1-365 oder 1-366)
 
# Ermittle das aktuelle Jahr
current_year=$(date +%Y)
 
# Ermittle den aktuellen Monat
current_month=$(date +%m)
 
# Festlegen des Backup-Level basierend auf dem Wochentag
# Montags: Vollständiges wöchentliches Backup
# An anderen Tagen: Inkrementelles tägliches Backup
if [ $current_weekday -eq 1 ]; then
    backup_level="Wöchentlich"
    backup_folder="$BACKUP_DIR/Wochenbackups"
    mkdir -p "$backup_folder/$current_weekday"
    backup_options="-avz --delete"
else
    backup_level="Täglich"
    backup_folder="$BACKUP_DIR/TäglicheInkrementelleBackups/$current_weekday"
    mkdir -p "$backup_folder"
    backup_options="-avz --delete --link-dest=$BACKUP_DIR"
fi
 
# Durchführung des Backups
rsync $backup_options "$SOURCE_DIR/" "$backup_folder/"
 
# Wenn es Montag ist, prüfen wir, ob ein monatliches Backup durchgeführt werden muss
if [ $current_weekday -eq 1 ]; then
    # Wenn der Monat beginnt, führen wir ein monatliches Vollbackup durch
    if [ "$(date +%d)" == "01" ]; then
        backup_folder="$BACKUP_DIR/Monatsbackups"
        mkdir -p "$backup_folder"
        backup_options="-avz --delete"
        rsync $backup_options "$SOURCE_DIR/" "$backup_folder/$current_year/$current_month"
    fi
fi
 
# Wenn es Januar ist, prüfen wir, ob ein jährliches Backup durchgeführt werden muss
if [ $current_month -eq 01 ]; then
    # Wenn das Jahr beginnt, führen wir ein jährliches Vollbackup durch
    if [ "$(date +%d)" == "01" ]; then
        backup_folder="$BACKUP_DIR/JährlicheBackups"
        mkdir -p "$backup_folder"
        backup_options="-avz --delete"
        rsync $backup_options "$SOURCE_DIR/" "$backup_folder/$current_year"
    fi
fi
 
echo "Backup für $backup_level erfolgreich abgeschlossen."