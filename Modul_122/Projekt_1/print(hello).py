#Dieses Script Wurde im Modul 122 Erstellt und sollte Anhand von .txt Dateien ein Netzwerk Simulieren. Diese Dateien werden dann in Python Ausgelesen und in einem GUI dargestellt.




#Modul Zeit Importieren
import time

#Scannen des Inhalts der simulierten PCs (Textdateien)
datei = open('PC01.txt', 'r') #datei.read() zum auslesen
datei1 = open('PC02.txt', 'r')
datei2 = open('PC03.txt', 'r')
datei3 = open('PC04.txt', 'r')
datei4 = open('PC05.txt', 'r')


#Endlosschlaufe mit Usereingabe
i = 1
while i == 1:
    #User Entscheidet sich ob er den Scann durchführen will
    Jaodernein = input("Willst du das Netzwerk Scannen (J/N)")
    if Jaodernein == "J": #Wenn er den scann durchführen will dann wird Gescannt
        # Simulierung für ein erlebniss eines Scanns
        print("Netzwerk-Scann wird Ausgeführt...")
        time.sleep(3)
        print("_________________________________________________________________")
        print("5 Geräte Gefunden...")
        time.sleep(3)
        print("_________________________________________________________________")
        print("Informationen Auslesen...")
        time.sleep(3)
        print("_________________________________________________________________")

        # GUI erstellen
        from tkinter import *

        from tkinter import ttk

        window = Tk()

        # Fenstergrösse setzen
        window.geometry('750x500')

        # Titel setzen
        window.title("Welcome to LikeGeeks app")

        # Verschiedene Seiten Erstellen
        tab_control = ttk.Notebook(window)

        tab1 = ttk.Frame(tab_control)

        tab2 = ttk.Frame(tab_control)

        tab3 = ttk.Frame(tab_control)

        tab4 = ttk.Frame(tab_control)

        tab5 = ttk.Frame(tab_control)

        # Titel der Seiten definieren
        tab_control.add(tab1, text='PC01')

        tab_control.add(tab2, text='PC02')

        tab_control.add(tab3, text='PC03')

        tab_control.add(tab4, text='PC04')

        tab_control.add(tab5, text='PC05')

        # Inhalt der Seiten von den Simulierten PCs auslesen
        lbl1 = Label(tab1, text=datei.read())

        lbl1.grid(column=0, row=0)

        lbl2 = Label(tab2, text=datei1.read())

        lbl2.grid(column=0, row=0)

        lbl3 = Label(tab3, text=datei2.read())

        lbl3.grid(column=0, row=0)

        lbl4 = Label(tab4, text=datei3.read())

        lbl4.grid(column=0, row=0)

        lbl5 = Label(tab5, text=datei4.read())

        lbl5.grid(column=0, row=0)

        tab_control.pack(expand=1, fill='both')

        #Fenster Permanent Ersichtlich Machen bis es geschlossen wird
        window.mainloop()
        break
    elif Jaodernein == "N": #Wenn der User Den Scann nicht Durchführen will ist das Programm Beendet
        print("Kein Netzwerk-Scann wird durchgeführt")
        break
    else: #Wenn der User etwas Anderes als J oder N eingibt dann fragt es ihn nochmal ob er Scannen will (Fehlerbehebung)
        print("Ungültige eingabe")


