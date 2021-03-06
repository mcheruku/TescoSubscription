/*
	Created By:       Manjunathan Raman
	Date created:     10-Oct-2012
	Purpose:          Insert records to table [Coupon].[CouponAttributesReference]
	Usage:            Data used for Click And Collect 
	Data Type:        Reference Data - Updated via DB script 


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
	[AttributeID] [smallint] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[UTCCreatedDateTime] [smalldatetime] NOT NULL,
	[UTCUpdatedDateTime] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_CouponAttributesReference] PRIMARY KEY CLUSTERED 
(
	[AttributeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_CouponAttributesReference_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_CouponAttributesReference_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	AttributeID,
	Description,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 1,'PlanReference','2012-10-04 11:11:00','2012-10-04 11:11:00'
UNION ALL
SELECT 2,'EffectiveStartDate','2012-10-04 11:11:00','2012-10-04 11:11:00'
UNION ALL
SELECT 3,'EffectiveEndDate','2012-10-04 11:11:00','2012-10-04 11:11:00'
UNION ALL
SELECT 4,'MaxRedemption','2012-10-04 11:11:00','2012-10-04 11:11:00'
UNION ALL
SELECT 5,'LapsePeriod','2012-10-04 11:11:00','2012-10-04 11:11:00'

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [Coupon].[CouponAttributesReference] DestTable
ON  ToInsert.AttributeID = DestTable.AttributeID

INSERT INTO [Coupon].[CouponAttributesReference](
	AttributeID,
	Description,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.AttributeID,
	ToInsert.Description,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [Coupon].[CouponAttributesReference] DestTable
ON  ToInsert.AttributeID = DestTable.AttributeID
WHERE DestTable.AttributeID Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[CouponAttributesReference].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [Coupon].[CouponAttributesReference].'

DROP TABLE #INSERTDATA

GO
