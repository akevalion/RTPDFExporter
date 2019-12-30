"
A RTPDFVisitorTest is a test class for testing the behavior of RTPDFVisitor
"
Class {
	#name : #RTPDFVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'visitor',
		'canvas',
		'nullShape'
	],
	#category : #'RoassalPdfExporter-Tests'
}

{ #category : #'tests-accessing' }
RTPDFVisitorTest >> setUp [
	visitor:=RTPDFVisitor new.
	canvas:=TRCanvas new.
	nullShape:=TRNoShape new.
]

{ #category : #'tests-accessing' }
RTPDFVisitorTest >> testCanvasSize [
]

{ #category : #'tests-initialization' }
RTPDFVisitorTest >> testInitialize [
	| tmpVisitor |
	self assert: tmpVisitor isNil.
	tmpVisitor:=RTPDFVisitor new.
	self deny: tmpVisitor page isNil
]

{ #category : #'tests-accessing' }
RTPDFVisitorTest >> testPage [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitAbstractLine [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitBezierShape [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitBoxShape [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitCanvas [
	self deny: visitor canvasSize = canvas extent.
	canvas accept: visitor.
	self assert: visitor canvasSize = canvas extent.
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitEllipseShape [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitLabelShape [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitLineShape [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitMondrianViewBuilder [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitNoShape [
	nullShape accept: visitor.
	
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitShape [
]

{ #category : #'tests-visitor' }
RTPDFVisitorTest >> testVisitView [
]
