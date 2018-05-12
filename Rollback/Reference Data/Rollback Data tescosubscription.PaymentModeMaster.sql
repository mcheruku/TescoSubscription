/*
	Created By:       Rajendra Singh
	Date created:     27-Jul-2011
	Purpose:          Rollback changes made to table [tescosubscription].[PaymentModeMaster]
	Usage:            Data used for Click And Collect 
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

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

SELECT @notExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[PaymentModeMaster] DestTable
ON  ToInsert.PaymentModeID = DestTable.PaymentModeID
WHERE DestTable.PaymentModeID Is Null


DELETE [tescosubscription].[PaymentModeMaster]
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[PaymentModeMaster] DestTable
ON  ToInsert.PaymentModeID = DestTable.PaymentModeID

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [tescosubscription].[PaymentModeMaster].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [tescosubscription].[PaymentModeMaster].'

DROP TABLE #INSERTDATA

GO
