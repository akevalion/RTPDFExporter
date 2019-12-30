"
I am a class to add a menu in the gt-inspector
"
Class {
	#name : #GLMPDFExportingAction,
	#superclass : #GLMAbstractExportingAction,
	#category : #'RoassalPdfExporter-Glamour-Action'
}

{ #category : #hooks }
GLMPDFExportingAction >> doExportToFull: fileName [
	| stream |
	stream := fileName writeStream.
	[ RTPDFExporter new
		stream: stream;
		exportView: self roassalView ] ensure: [ stream ifNotNil: [ stream close ] ]
]

{ #category : #hooks }
GLMPDFExportingAction >> extensions [
	^ #('pdf')
]

{ #category : #hooks }
GLMPDFExportingAction >> titleExtension [
	^ 'PDF'
]
