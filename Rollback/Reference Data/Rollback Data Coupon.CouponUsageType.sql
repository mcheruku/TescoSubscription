USE [TescoSubscription]
GO

/*

	Author:			Robin
	Date created:	14-Jan-2014
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Rollback  reference data for Campaign discount Type
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/

SET NOCOUNT ON

DECLARE @Deleted INT, @Notexists INT

SELECT @Deleted = 0, @Notexists = 0

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

SELECT @NotExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [Coupon].[CouponUsageType] DestTable
ON  ToInsert.UsageTypeID = DestTable.UsageTypeID
WHERE DestTable.UsageTypeID Is Null


DELETE [Coupon].[CouponUsageType]
FROM #INSERTDATA ToInsert
JOIN [Coupon].[CouponUsageType] DestTable
ON  ToInsert.UsageTypeID = DestTable.UsageTypeID

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [Coupon].[CouponUsageType].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [Coupon].[CouponUsageType].'

DROP TABLE #INSERTDATA

GO
