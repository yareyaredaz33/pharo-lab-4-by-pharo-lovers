"
""клас футболіста""
"
Class {
	#name : 'FootballPlayer',
	#superclass : 'Sportsperson',
	#instVars : [
		'club',
		'annualContract',
		'goalsScored'
	],
	#category : 'Sports',
	#package : 'Sports'
}

{ #category : 'as yet unclassified' }
FootballPlayer class >> loadFromTxtFile [
    | file stream lastNameva ageva nationalityva clubva contractva goalsva athlete |
    
    file := 'sportPerson1.txt' asFileReference. 
    stream := file readStream.
    
    lastNameva := (stream nextLine findTokens: ':') second. 
    ageva := (stream nextLine findTokens: ':') second asInteger. 
    nationalityva := (stream nextLine findTokens: ':') second.
    
    clubva := (stream nextLine findTokens: ':') second. 
    contractva := (stream nextLine findTokens: ':') second asInteger.
    goalsva := (stream nextLine findTokens: ':') second asInteger.

    athlete := self new initializeWithLastName: lastNameva 
                               age: ageva 
                               nationality: nationalityva 
                               club: clubva 
                               contract: contractva 
                               goals: goalsva.
    
    stream close.
    ^athlete.
]

{ #category : 'accessing' }
FootballPlayer >> displayInformation [
    ^ String streamContents: [ :stream |
        stream
            nextPutAll: (super displayInformation);
            nextPutAll: 'Club: '; nextPutAll: club; cr;
            nextPutAll: 'Annual Contract: '; nextPutAll: annualContract asString; cr;
            nextPutAll: 'Goals Scored: '; nextPutAll: goalsScored asString; cr;
            nextPutAll: 'Total Earnings: ', self totalEarnings asString; cr ].
]

{ #category : 'initialization' }
FootballPlayer >> initializeWithLastName: aLastName age: anAge nationality: aNationality club: aClub contract: aContract goals: goalsCount [
    super initializeWithLastName: aLastName age: anAge nationality: aNationality.
    club := aClub.
    annualContract := aContract.
    goalsScored := goalsCount.
]

{ #category : 'accessing' }
FootballPlayer >> totalEarnings [
    ^ annualContract * (1 + (goalsScored * 0.01)).
]
