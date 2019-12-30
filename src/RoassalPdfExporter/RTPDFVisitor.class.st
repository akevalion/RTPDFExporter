"
I am a visitor that collects the information from an RTView to a pdf stream
"
Class {
	#name : #RTPDFVisitor,
	#superclass : #RTVisitor,
	#instVars : [
		'page',
		'translation'
	],
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #accessing }
RTPDFVisitor >> adjustWith: aPoint [
	translation := aPoint.
]

{ #category : #accessing }
RTPDFVisitor >> canvasSize [
	^canvasSize
]

{ #category : #initialization }
RTPDFVisitor >> initialize [
	super initialize.
	page:=PDFPage new.
]

{ #category : #helpers }
RTPDFVisitor >> pFor: aPoint [
	^ aPoint + translation
]

{ #category : #accessing }
RTPDFVisitor >> page [
	^page
]

{ #category : #helpers }
RTPDFVisitor >> pmmFor: aPoint [
	| p |
	p := self pFor: aPoint.
	^ p x mm @ p y mm
]

{ #category : #visitor }
RTPDFVisitor >> visitAbstractLine: anAbstractLine [
	anAbstractLine accept: anAbstractLine
	
]

{ #category : #visitor }
RTPDFVisitor >> visitArcShape: arc [
	| fill stroke position |
	fill := RTShapeCommons getPDFFillColor: arc.
	stroke := RTShapeCommons getPDFBorderColor: arc.
	position := self pmmFor: arc position.
	
	page add: ((PDFArcElement new 
		from: position)
		innerRadius: arc innerRadius mm;
		externalRadius: arc externalRadius mm;
		alphaAngle: arc alphaAngle;
		betaAngle: arc betaAngle;
		fillColor: fill;
		opacity: (PDFOpacityNormal alpha: arc color alpha)).
		
]

{ #category : #visitor }
RTPDFVisitor >> visitArrowShape: anArrow [
	| vector u unit middle left right to from |
	to := self pFor: anArrow to.
	from := self pFor: anArrow from.
	vector := to - from.
	u := vector normal.
	unit := vector / vector r.
	middle := to - (unit * anArrow mySize).
	left := middle - (u * anArrow baseSize / 2).
	right := middle + (u * anArrow baseSize / 2).
	page add:
				((PDFLineElement 
				from: left x  mm @ left y mm
				to: to x mm @ to y mm) 
				thickness: (RTUnitConversion pixelToMm: 1) mm;
				drawColor:(RTShapeCommons getPDFBorderColor: anArrow);
				opacity: (PDFOpacityNormal alpha: anArrow strokePaint alpha)).
	page add:
				((PDFLineElement 
				from: to x  mm @ to y mm
				to: right x mm @ right y mm) 
				thickness: (RTUnitConversion pixelToMm: 1) mm;
				drawColor:(RTShapeCommons getPDFBorderColor: anArrow);
				opacity: (PDFOpacityNormal alpha: anArrow strokePaint alpha))
	
]

{ #category : #visitor }
RTPDFVisitor >> visitBezierShape: aBezierShape [
	|points from|
	points:=aBezierShape points collect:[:p | self pmmFor: p].
	from:= points first.
	page add:
		((RTPDFBezierElement
		from: from
		points: points)
		thickness: (RTUnitConversion pixelToMm: 1) mm;
		drawColor: (RTShapeCommons getPDFFillColor: aBezierShape);
		opacity: (PDFOpacityNormal alpha: aBezierShape color alpha))
				
]

{ #category : #visitor }
RTPDFVisitor >> visitBitMapShape: shape [
	| s rect from extent |
	rect := shape encompassingRectangle.
	s := WriteStream on: ByteArray new.
	TRPlatform current pngReadWriterClass putForm: (shape form) onStream: s.
	from := self pmmFor: rect topLeft.
	extent := rect extent.
	page add:
				(PDFPngElement
				from: from
				dimension: extent x mm@ extent y mm
				fromStream: s contents readStream)
]

{ #category : #visitor }
RTPDFVisitor >> visitBoxShape: aBox [
	| borderColor fillColor rec from extent |
	borderColor := RTShapeCommons getPDFBorderColor: aBox.
	fillColor := RTShapeCommons getPDFFillColor: aBox.
	rec := aBox encompassingRectangle.
	from := self pmmFor: rec topLeft.
	extent := rec extent.
	page
		add:
			(PDFRectElement new
				from: from;
				dimension: extent x mm @ extent y mm;
				thickness: (RTUnitConversion pixelToMm: 1) mm;
				drawColor: borderColor;
				fillColor: fillColor;
				opacity: (PDFOpacityNormal alpha: aBox color alpha))
]

{ #category : #visitor }
RTPDFVisitor >> visitCanvas: aCanvas [
	aCanvas shapes do: [ :s | s accept: self ].
]

{ #category : #visitor }
RTPDFVisitor >> visitEllipseShape: anEllipse [
	| borderColor fillColor rect from extent thickness |
	borderColor := RTShapeCommons getPDFBorderColor: anEllipse.
	fillColor := RTShapeCommons getPDFFillColor: anEllipse.
	rect := anEllipse encompassingRectangle.
	from := self pmmFor: rect topLeft.
	extent := rect extent.
	thickness := anEllipse strokePaint ifNil: [ 0 ] 
		ifNotNil: [ anEllipse strokeWidth ].
	self page
		add:
			((PDFEllipseElement2 from: from dimension: extent x mm @ extent y mm)
				thickness: thickness mm;
				drawColor: borderColor;
				fillColor: fillColor;
				opacity: (PDFOpacityNormal alpha: anEllipse color alpha))
]

{ #category : #visitor }
RTPDFVisitor >> visitLabelShape: aLabel [
	| myFont color rect from to |
	color := RTShapeCommons getPDFFillColor: aLabel.
	rect := aLabel encompassingRectangle.
	from := self pmmFor: rect topLeft.
	aLabel angleInDegrees isZero ifFalse: [ from := self pmmFor: rect bottomLeft ].
	to := self pmmFor: rect extent.
	myFont := (PDFHelveticaFont size: (RTUnitConversion ptToMm: aLabel fontSize pt))
		bold: aLabel font isBold;
		italic: aLabel font isItalic.
	page add: ((PDFTextElement from: from dimension: to)
		textColor: color;
		text: aLabel text;
		font: myFont;
		rotation: aLabel angleInDegrees negated;
		opacity: (PDFOpacityNormal alpha: aLabel color alpha)).
]

{ #category : #visitor }
RTPDFVisitor >> visitLineShape: aLine [
	|startingPoint endingPoint|
	startingPoint:= self pmmFor: aLine from.
	endingPoint:= self pmmFor: aLine to.	
	page add:
				((PDFLineElement 
				from: startingPoint
				to: endingPoint) 
				thickness: aLine width mm;
				drawColor:(RTShapeCommons getPDFFillColor: aLine);
				opacity: (PDFOpacityNormal alpha: aLine color alpha))
]

{ #category : #visitor }
RTPDFVisitor >> visitMondrianViewBuilder: aView [
	aView view accept: self

]

{ #category : #visitor }
RTPDFVisitor >> visitNoShape: aShape [
	"Do nothing"
]

{ #category : #visitor }
RTPDFVisitor >> visitPolygonShape: polygon [
	| fill stroke position points |
	
	fill := RTShapeCommons getPDFFillColor: polygon.
	stroke := RTShapeCommons getPDFBorderColor: polygon.
	position := self pmmFor: polygon position.
	points := polygon vertices "collect: [ :p | self pmmFor: p]".
	page
		add:
			((PDFPolygonElement new from: position)
				points: points;
				drawColor: stroke;
				fillColor: fill;
				opacity: (PDFOpacityNormal alpha: polygon color alpha))
]

{ #category : #visitor }
RTPDFVisitor >> visitSVGPath: svg [
	| fill stroke position alpha |
	
	fill := RTShapeCommons getPDFFillColor: svg.
	stroke := RTShapeCommons getPDFBorderColor: svg.
	position := self pmmFor: svg position.
	alpha := 0.
	svg color ifNotNil: [ alpha := svg color alpha ].
	page
		add:
			((PDFSVGElement new from: position)
				curves: svg curves;
				unit: #mm;
				translation: [:p | (svg matrix transform: p)+translation ];
				drawColor: stroke;
				fillColor: fill;
				opacity: (PDFOpacityNormal alpha: alpha))
]

{ #category : #visitor }
RTPDFVisitor >> visitShape: aShape [
	aShape accept: self 
	
]

{ #category : #visitor }
RTPDFVisitor >> visitView: aView [
	aView canvas accept: self
]
