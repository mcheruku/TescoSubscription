/*
	Created By:       Rajendra Singh
	Date created:     27-Jul-2011
	Purpose:          Insert records to table [tescosubscription].[PaymentModeMaster]
	Usage:            Data used for subscriptions
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
	[PaymentModeID] [tinyint] NOT NULL,
	[PaymentModeName] [varchar](50) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_PaymentModeMaster] PRIMARY KEY CLUSTERED 
(
	[PaymentModeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_PaymentModeMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_PaymentModeMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	PaymentModeID,
	PaymentModeName)
SELECT 1,'CreditCard'
UNION ALL
SELECT 2,'ECoupon'

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[PaymentModeMaster] DestTable
ON  ToInsert.PaymentModeID = DestTable.PaymentModeID

INSERT INTO [tescosubscription].[PaymentModeMaster](
	PaymentModeID,
	PaymentModeName,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.PaymentModeID,
	ToInsert.PaymentModeName,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[PaymentModeMaster] DestTable
ON  ToInsert.PaymentModeID = DestTable.PaymentModeID
WHERE DestTable.PaymentModeID Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[PaymentModeMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[PaymentModeMaster].'

DROP TABLE #INSERTDATA

GO
