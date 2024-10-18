"
""клас тенісиста""
"
Class {
	#name : 'TennisPlayer',
	#superclass : 'Sportsperson',
	#instVars : [
		'worldRanking',
		'tournamentEarnings'
	],
	#category : 'Sports',
	#package : 'Sports'
}

{ #category : 'accessing' }
TennisPlayer >> displayInformation [
    ^ String streamContents: [ :stream |
        stream
            nextPutAll: (super displayInformation);
            nextPutAll: 'World Ranking: '; nextPutAll: worldRanking asString; cr;
            nextPutAll: 'Earnings (last 3 tournaments): ', tournamentEarnings asString; cr;
            nextPutAll: 'Total Earnings: ', self totalEarnings asString; cr ].
]

{ #category : 'initialization' }
TennisPlayer >> initializeWithLastName: aLastName age: anAge nationality: aNationality worldRanking: aRanking earnings: earningsArray [
    super initializeWithLastName: aLastName age: anAge nationality: aNationality.
    worldRanking := aRanking.
    tournamentEarnings := earningsArray.
]

{ #category : 'printing' }
TennisPlayer >> printEarnings [
    Transcript show: 'Tennis Player: ', lastName, ' Earnings: ', self totalEarnings asString; cr.
]

{ #category : 'as yet unclassified' }
TennisPlayer >> sportType [ 
        ^ 'Тенісист'. 
    
]

{ #category : 'accessing' }
TennisPlayer >> totalEarnings [
    | lastThreeTournaments |
    lastThreeTournaments := tournamentEarnings size > 3
        ifTrue: [ tournamentEarnings last: 3 ]
        ifFalse: [ tournamentEarnings ].
    ^ lastThreeTournaments inject: 0 into: [ :sum :earnings | sum + earnings ].
]

{ #category : 'accessing' }
TennisPlayer >> worldRanking [ 
    ^ worldRanking. 
]
