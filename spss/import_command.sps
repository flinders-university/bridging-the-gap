* Encoding: UTF-8.


GET DATA  /TYPE=TXT
  /FILE="/Users/aidancornelius/Downloads/6 (1).csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=1
  /IMPORTCASE=ALL
  /VARIABLES=
  FirstName A14
  LastName A14
  UniqueIdentifier F2.0
  QuestionGrouping F1.0
  QuestionNumber F3.0
  QuestionText A230
  Answer A49
  AnswerExtended A18
  ExtPresence F1.0.
CACHE.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

