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
            nextPutAll: (super displayInformation); cr;
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

{ #category : 'accessing' }
TennisPlayer >> totalEarnings [
    ^ tournamentEarnings inject: 0 into: [ :sum :earnings | sum + earnings ].
]
