# take-home-exam


Reicht hier bitte die Lösung zum Take-Home-Exam bis am 11. Januar 2019, 23.55 Uhr ein. 

Tipps:

- Versucht zuerst die Aufgaben inhaltlich richtig zu lösen: Berechnungen müssen richtig und Grafiken sauber dargestellt sein. 
Interpretationen müssen im Markdown Dokument, in einem separaten Word Dokument oder als Kommentar im R-Skript deutlich ersichtbar 
sein. Kurzer Code gibt zusätzliche Punkte.

- Eure Lösungen sollten für uns möglichst einfach reproduzierbar sein.
 Bitte R-Skript, Tabellen und Grafiken zusammen hochladen. Wir empfehlen Euch Markdown zu verwenden, 
 was es vereinfacht, alles in ein Dokument zu packen (am besten .html, vergesst aber nicht den Markdown Code (.rmd)). 

Bei Fragen wird Ihnen im Forum wieder geholfen, wenn sie jeweils den Code (inkl. Dateneinlesung) miterwähnen.


22 Take-Home-Exam:

22.1 Ebay-Auktionen

Laden Sie die Daten http://www.farys.org/daten/ebay.dta. Es handelt sich um Ebaydaten von Mobiltelefonauktionen.

 Die Variablen sind:

	sold: Ob das Mobiltelefon verkauft wurde
	price: Der erzielte Verkauftspreis
	sprice: Der Startpreis der Auktion
	sepos: Anzahl positiver Bewertungen des Verkäufers
	seneg: Anzahl negativer Bewertungen des Verkäufers
	subcat: Das Modell des Mobiltelefons
	listpic: Kategorialer Indikator, ob die Auktion ein Thumbnail, ein “has-picture-icon” oder kein Thumbnail hat.
	listbold: Dummy, ob die Auktion fettgedruckt gelistet ist
	sehasme: Dummy, ob der Verkäufer eine “Me-page” hat oder nicht

Sie interessieren sich dafür, ob Mobiltelefone bei Auktionen einen höheren Preis erzielen, wenn der Verkäufer des Geräts 
eine gute Bewertung hat. 

Erzeugen Sie eine Variable rating, die den Anteil positiver Bewertungen an den Gesamtbewertungen misst. 
Schliessen Sie Fälle aus den Daten aus, für die weniger als 12 positive Bewertungen vorliegen.

Bilden Sie zudem eine Variable makellos (TRUE/FALSE), ob der Verkäufer ein makelloses Rating (>98% positive Bewertungen) 
hat oder nicht.

Zeichnen Sie einen farblich geschichteten Boxplot: 
	Y-Achse=Preis, 
	X-Achse=Gerätetyp, 

farblich geschichtet nach Bewertung (makellos=grün sonst=rot). Orientieren Sie sich z.B. am Vorschlag von “Roger Bivand” im Helpfile zu boxplot(). 
Exportieren Sie die Grafik als PDF. Erzielen (rein optisch) die Verkäufer mit makellosem Rating einen höheren Verkaufspreis?

Rechnen Sie zwei kleine Regressionsmodelle für den Preis von verkauften Geräten. 
	Modell 1 soll als Prädiktoren den Modelltyp und das Rating beinhalten. 
	Modell 2 soll zusätzlich die Variable listpic beinhalten.

	Haben das Rating und die Thumbnails einen Einfluss auf den Verkaufspreis? Exportieren Sie eine Regressionstabelle, die beide Modelle beinhaltet.

22.2 Webscraping / Tidying
Betrachten Sie den Wikipedia-Eintrag zum Klima in Bern: https://de.wikipedia.org/wiki/Bern#Klima. Lesen Sie die Tabelle “Monatliche Durchschnittstemperaturen und -niederschläge für Bern 1981-2010” ein. Verwenden Sie hierfür die Tools aus dem Kapitel “Datenimport aus HTML/XML”“, z.B. das Package rvest.

Konzentrieren Sie sich auf die ersten drei Zeilen (Monat, Max. Temperatur, Min. Temperatur) und säubern Sie die Daten (vgl. Kapitel 15.1.), um auf folgende (oder hübschere) Tabelle zu kommen:

load("the_tabelle.RData")
suppressWarnings(library(knitr, warn.conflicts = FALSE, quietly=TRUE))

kable(tabelle)
Monat		Max		Min
Januar		2.8		-3.6
Februar		4.7		-3.1
März		9.5		0.2
April		13.4	3.0
Mai			18.2	7.4
Juni		21.6	10.5
Juli		24.3	12.5
August		23.7	12.3
September	19.1	8.9
Oktober		13.8	5.4
November	7.3		0.4
Dezember	3.5		-2.3

Achten Sie auf gut lesbaren Code! Der Einreichungstermin ist der 11. Januar 2019.

