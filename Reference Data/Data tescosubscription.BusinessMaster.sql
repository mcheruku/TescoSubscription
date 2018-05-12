/*
	Created By:       Saritha Kommineni
	Date created:     27-Jul-2011
	Purpose:          Insert records to table [tescosubscription].[BusinessMaster]
	Usage:            Data used for Grocery Subs
	

	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
	[BusinessID] [tinyint] NOT NULL,
	[BusinessName] [varchar](30) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_tescosubscription.BusinessMaster] PRIMARY KEY CLUSTERED 
(
	[BusinessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_BusinessMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_BusinessMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	BusinessID,
	BusinessName)
	
SELECT 1,'Grocery'

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[BusinessMaster] DestTable
ON  ToInsert.BusinessID = DestTable.BusinessID

INSERT INTO [tescosubscription].[BusinessMaster](
	BusinessID,
	BusinessName,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.BusinessID,
	ToInsert.BusinessName,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[BusinessMaster] DestTable
ON  ToInsert.BusinessID = DestTable.BusinessID
WHERE DestTable.BusinessID Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[BusinessMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[BusinessMaster].'

DROP TABLE #INSERTDATA

GO
