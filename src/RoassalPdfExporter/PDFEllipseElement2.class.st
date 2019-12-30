Class {
	#name : #PDFEllipseElement2,
	#superclass : #PDFEllipseElement,
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #render }
PDFEllipseElement2 >> producePageElementCodeWith: aPDFGenerator StyleSheet: aStyleSheet [
	
	| hw hh magic cx cy lx rx ty by center w h|

	magic := 0.551784.
	center := aPDFGenerator determinePositionOnCurrentPage: self center.
	w := aPDFGenerator convertToPoints: self width.
	h := aPDFGenerator convertToPoints: self height.
	cx := center x.
	cy := center y.
	hw := 0.5*magic * w.
	hh := 0.5*magic * h.
	lx := cx- (w / 2 ).
	rx := cx + (w / 2 ).
	ty := cy - (h / 2 ).
	by := cy + (h / 2 ).
	
	^ (String streamContents: [ :s |
		s print: cx; space; print: ty; nextPutAll: ' m '; 
		print: cx+hw; space; print: ty; space;
		print: rx; space; print: cy-hh; space;
		print: rx; space; print: cy; nextPutAll: ' c ';
		print: rx; space; print: cy+hh; space;
		print: cx+hw; space; print: by; space;
		print: cx; space; print: by; nextPutAll: ' c ';
		print: cx-hw; space; print: by; space;
		print: lx; space; print:  cy+hh; space;
		print: lx; space; print:cy; nextPutAll: ' c ';
		print: lx; space; print: cy-hh; space;
		print: cx-hw; space; print: ty; space;
		print: cx; space; print: ty; nextPutAll: ' c h ';
		nextPutAll:( self fillMode: (aStyleSheet filled))
	]).
 	
]
