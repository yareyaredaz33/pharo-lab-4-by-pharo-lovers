Class {
	#name : 'Athlete',
	#superclass : 'Object',
	#instVars : [
		'surname',
		'age',
		'nationality'
	],
	#category : 'SportsPackage',
	#package : 'SportsPackage'
}

{ #category : 'comparing' }
Athlete >> = anObject [ [
    ^ (anObject isKindOf: self class)
        and: [ surname = anObject surname and: [ age = anObject age ] ].
]
]

{ #category : 'accessing' }
Athlete >> age [ [
    ^ age.
]
]

{ #category : 'initialization' }
Athlete >> initializeSurname: aSurname age: anAge nationality: aNationality [ [
    surname := aSurname.
    age := anAge.
    nationality := aNationality.
]
]

{ #category : 'accessing' }
Athlete >> nationality [ [
    ^ nationality.
]
]

{ #category : 'printing' }
Athlete >> printOn: aStream [ [
    aStream nextPutAll: 'Athlete: ', surname, ', Age: ', age asString, ', Nationality: ', nationality.
]
]

{ #category : 'accessing' }
Athlete >> surname [ [
    ^ surname.
]
]
