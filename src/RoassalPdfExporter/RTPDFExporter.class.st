"
I am the exporter of an instance of RTView
"
Class {
	#name : #RTPDFExporter,
	#superclass : #RTObject,
	#instVars : [
		'document',
		'stream'
	],
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #public }
RTPDFExporter class >> export: anRTBuilder [
	
	^ self new exportView: anRTBuilder view.
]

{ #category : #public }
RTPDFExporter class >> exportCanvas: aCanvas [

	^ self new exportCanvas: aCanvas
]

{ #category : #public }
RTPDFExporter class >> exportView: aView [

	^ self new exportView: aView.
]

{ #category : #exporting }
RTPDFExporter >> exportCanvas: aCanvas [
	| rec extent  pdfVisitor |
	rec := aCanvas encompassingRectangle.
	extent := rec extent + 5.
	pdfVisitor := RTPDFVisitor new adjustWith: (rec topLeft-2.5) negated.
	
	aCanvas accept: pdfVisitor.
	
	document format: (PDFCustomFormat new 
		size: (RTUnitConversion ptToMm: extent x) point 
				@ (RTUnitConversion ptToMm: extent y) point).
	
	document add: pdfVisitor page.
	document exportTo: stream.
	
]

{ #category : #exporting }
RTPDFExporter >> exportView: aView [
	self exportCanvas: aView canvas
	
]

{ #category : #initialization }
RTPDFExporter >> initialize [
	super initialize.
	document:=PDFDocument new.
]

{ #category : #accessing }
RTPDFExporter >> stream [
	^ stream
]

{ #category : #accessing }
RTPDFExporter >> stream: aStream [
	stream := aStream
]
