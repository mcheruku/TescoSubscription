USE [TescoSubscription]
GO

/*

	Author:			Robin
	Date created:	14-Jan-2014
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Holds reference data for Campaign discount Type
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/
SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData([UsageTypeID] [tinyint] NOT NULL,
	[UsageName] [nvarchar](80) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL)

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_DiscountType_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_DiscountType_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	UsageTypeId,
	UsageName)	
SELECT 1,'Signups'
UNION ALL
SELECT 2,'Signups & Renewals'

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [Coupon].[CouponUsageType] DestTable
ON  ToInsert.UsageTypeId = DestTable.UsageTypeId

INSERT INTO [Coupon].[CouponUsageType](
	UsageTypeId,
	UsageName,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.UsageTypeId,
	ToInsert.UsageName,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [Coupon].[CouponUsageType] DestTable
ON  ToInsert.UsageTypeId = DestTable.UsageTypeId
WHERE DestTable.UsageTypeId Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[CouponUsageType].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[CouponUsageType].'

DROP TABLE #INSERTDATA

GO
