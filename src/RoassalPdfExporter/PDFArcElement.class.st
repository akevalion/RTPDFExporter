"
I am an element to draw an arc in a pdf way
"
Class {
	#name : #PDFArcElement,
	#superclass : #PDFDraw,
	#instVars : [
		'innerRadius',
		'externalRadius',
		'alphaAngle',
		'betaAngle'
	],
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #accessing }
PDFArcElement >> alphaAngle [
	^ alphaAngle
]

{ #category : #accessing }
PDFArcElement >> alphaAngle: aNumber [
	alphaAngle := aNumber
]

{ #category : #'path commands' }
PDFArcElement >> arcRadianStart: aAngle end: bAngle center: center radius: radius cw: direction [
	| inc cv ext arad arcSegs x y |
	ext := (bAngle - aAngle).
	arad := aAngle degreesToRadians.
	direction ifTrue: [ 
		ext := (aAngle - bAngle) negated. ].
	(ext >= 360.0 or: [ ext <= -360 ]) ifTrue: [ 
		arcSegs := 4.
		inc := Float pi / 2.
		cv := 0.5522847498307933.
		ext < 0 ifTrue: [ inc := inc negated. cv := cv negated. ] ] 
	ifFalse: [ 
		arcSegs := (ext abs / 90) ceiling.
		inc := (ext / arcSegs) degreesToRadians.
		cv := self btan: inc.
		cv = 0 ifTrue: [ arcSegs = 0 ]. ].
	radius <= 0 ifTrue: [ arcSegs = 0 ].
	x := center x.
	y := center y.
	^ String
		streamContents: [ :s | 
			s print: arad cos * radius + x; space; 
				print: arad sin * radius + y; space; nextPutAll: ' m '.
			1 to: arcSegs do: [:index | | angle relx rely |
				angle := arad.
				angle := inc * (index - 1)+angle.
				relx := angle cos.
				rely := angle sin.
				s print: (relx - (cv * rely) ) * radius + x; space;
					print: (rely + (cv * relx ))* radius + y; space.
				angle := angle + inc.
				relx := angle cos.
				rely := angle sin.
				s print: (relx + (cv * rely)) * radius + x; space;
					print: (rely - (cv * relx)) * radius+ y; space;
					print: relx * radius + x; space;
					print: rely * radius + y; nextPutAll: ' c '. ] ].
		
	

]

{ #category : #accessing }
PDFArcElement >> betaAngle [
	^ betaAngle
]

{ #category : #accessing }
PDFArcElement >> betaAngle: aNumber [
	betaAngle := aNumber
]

{ #category : #'path commands' }
PDFArcElement >> btan: inc [
	|increment | 
	increment := inc / 2.0.
	^ 4 / 3 * increment sin / (1+ increment cos )
	
]

{ #category : #accessing }
PDFArcElement >> externalRadius [
	^ externalRadius
]

{ #category : #accessing }
PDFArcElement >> externalRadius: aNumber [
	externalRadius := aNumber
]

{ #category : #accessing }
PDFArcElement >> innerRadius [
	^ innerRadius
]

{ #category : #accessing }
PDFArcElement >> innerRadius: aNumber [
	innerRadius := aNumber
]

{ #category : #'path commands' }
PDFArcElement >> lineTo: p [
	^ String
		streamContents: [ :s | 
			s
				print: p x;
				space;
				print: p y;
				space;
				nextPutAll: PDFByteCode line;
				space ]
]

{ #category : #'path commands' }
PDFArcElement >> producePageElementCodeWith: aPDFGenerator StyleSheet: aStyleSheet [
	| aAngle bAngle i e aCos aSin bCos bSin p arad brad |
	^ String
		streamContents: [ :s | 
			aAngle := self alphaAngle value.
			bAngle := self betaAngle value.
			arad := aAngle degreesToRadians.
			brad := bAngle degreesToRadians.
			i := aPDFGenerator convertToPoints: self innerRadius.
			e := aPDFGenerator convertToPoints: self externalRadius.
			aCos := arad cos.
			aSin := arad sin.
			bCos := brad cos.
			bSin := brad sin.
			p := aPDFGenerator determinePositionOnCurrentPage: self from.
			s
				nextPutAll:
					(self
						arcRadianStart: aAngle
						end: bAngle
						center: p
						radius: i
						cw: false);
				nextPutAll: (self lineTo: (e*bCos)@(e*bSin)+ p);
				nextPutAll:
					(self
						arcRadianStart: bAngle
						end: aAngle
						center: p
						radius: e
						cw: true);
				nextPutAll: (self lineTo: (i * aCos) @ (i * aSin) + p);
				nextPutAll: (self fillMode: aStyleSheet filled).
			]
]

{ #category : #accessing }
PDFArcElement >> requiredAttributes [
	^ #( from alphaAngle betaAngle innerRadius externalRadius )
]
