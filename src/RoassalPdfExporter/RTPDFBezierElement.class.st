"
I am a class to define a Bezier element in the roassal view
"
Class {
	#name : #RTPDFBezierElement,
	#superclass : #PDFBezierCurveElement,
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #render }
RTPDFBezierElement >> producePageElementCodeWith: aPDFGenerator StyleSheet: aStyleSheet [
	| p1 p2 p3 |
	^ String streamContents: [ :s |
		p1 := points first.
		s nextPutAll: (self moveTo: p1 with: aPDFGenerator).
		2 to: points size - 2 do: [ :i |
			p1 := points at: i.
			p3 := aPDFGenerator determinePositionOnCurrentPage: p1.
			p2 := aPDFGenerator determinePositionOnCurrentPage: ((p1 + (points at: i + 1)) / 2).
			s
				print: p3 x; space; print: p3 y; space;
				print: p2 x; space; print: p2 y; space;
				print: p2 x; space; print: p2 y; nextPutAll: ' c '.
			 ].
		p1 := aPDFGenerator determinePositionOnCurrentPage: (points at: points size -1).
		p2 := aPDFGenerator determinePositionOnCurrentPage: points last.
		s
			print: p1 x; space; print: p1 y; space;
			print: p2 x; space; print: p2 y; space;
			print: p2 x; space; print: p2 y; nextPutAll: ' c '.
		s nextPutAll: PDFByteCode noFilling ].
]
