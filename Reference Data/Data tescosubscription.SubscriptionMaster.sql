/*
	Created By:       Saritha Kommineni
	Date created:     27-Jul-2011
	Purpose:          Insert records to table [tescosubscription].[SubscriptionMaster]
	Usage:            Data used for Grocery SUbs
	

	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
	[SubscriptionID] [tinyint] NOT NULL,
	[SubscriptionName] [varchar](30) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_tescosubscription.SubscriptionMaster] PRIMARY KEY CLUSTERED 
(
	[SubscriptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_SubscriptionMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_SubscriptionMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	SubscriptionID,
	SubscriptionName)
	
SELECT 1,'Delivery'

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[SubscriptionMaster] DestTable
ON  ToInsert.SubscriptionID = DestTable.SubscriptionID

INSERT INTO [tescosubscription].[SubscriptionMaster](
	SubscriptionID,
	SubscriptionName,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.SubscriptionID,
	ToInsert.SubscriptionName,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[SubscriptionMaster] DestTable
ON  ToInsert.SubscriptionID = DestTable.SubscriptionID
WHERE DestTable.SubscriptionID Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[SubscriptionMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[SubscriptionMaster].'

DROP TABLE #INSERTDATA

GO
