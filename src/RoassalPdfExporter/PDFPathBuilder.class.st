"
I am a builder to create svg-paths for pdf

This is a class that we need to check
"
Class {
	#name : #PDFPathBuilder,
	#superclass : #AthensCairoPathBuilder,
	#instVars : [
		'stream',
		'currentPoint',
		'translation',
		'generator',
		'unit'
	],
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #'path commands' }
PDFPathBuilder >> closePath [
	stream nextPutAll: ' h '
]

{ #category : #'path commands' }
PDFPathBuilder >> curveViaX: x1 Y: y1 viaX: x2 Y: y2 toX: x3 Y: y3 [
	| rel1 rel2 rel3 |
	currentPoint := x3 @ y3.
	rel1 := self toUnitPoint: x1 @ y1.
	rel2 := self toUnitPoint: x2 @ y2.
	rel3 := self toUnitPoint: currentPoint.
	stream
		print: rel1 x;
		space;
		print: rel1 y;
		space;
		print: rel2 x;
		space;
		print: rel2 y;
		space;
		print: rel3 x;
		space;
		print: rel3 y;
		nextPutAll: ' c '
]

{ #category : #accessing }
PDFPathBuilder >> generator: gene [
	generator := gene
]

{ #category : #'path commands' }
PDFPathBuilder >> getCurrentPoint [
	^ currentPoint
]

{ #category : #'path commands' }
PDFPathBuilder >> lineToX: x Y: y [
	| p |
	currentPoint := x @ y.
	p := self toUnitPoint: currentPoint.
	stream
		print: p x;
		space;
		print: p y;
		nextPutAll: ' l '
]

{ #category : #'path commands' }
PDFPathBuilder >> moveToX: x Y: y [
	| p |
	currentPoint := x @ y.
	p := self toUnitPoint: currentPoint.
	stream
		print: p x;
		space;
		print: p y;
		nextPutAll: ' m '
]

{ #category : #accessing }
PDFPathBuilder >> stream: s [
	stream := s
]

{ #category : #private }
PDFPathBuilder >> toUnitPoint: aPoint [
	| p |
	p := translation value: aPoint.
	p := (p x perform: unit) @ (p y perform: unit).
	p := generator determinePositionOnCurrentPage: p.
	^ p
]

{ #category : #accessing }
PDFPathBuilder >> translation: aBlock [
	"example
	self translate: [ :p | p + 5 ].
	"
	translation := aBlock
]

{ #category : #accessing }
PDFPathBuilder >> unit: u [
	unit:= u
]
