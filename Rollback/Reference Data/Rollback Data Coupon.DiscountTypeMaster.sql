USE [TescoSubscription]
GO

/*

	Author:			Robin
	Date created:	14-Jan-2014
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Rollback  reference data for DiscountTypeMaster
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/

SET NOCOUNT ON

DECLARE @Deleted INT, @Notexists INT

SELECT @Deleted = 0, @Notexists = 0

CREATE TABLE #InsertData([DiscountTypeId] [tinyint] NOT NULL,
	[DiscountName] [varchar](80) NOT NULL,
    [UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL)

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_DiscountType_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_DiscountType_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	DiscountTypeId,
	DiscountName)	
SELECT 1,'Amount'
UNION ALL
SELECT 2,'Percentage'
UNION ALL
SELECT 3,'ClubCardPoints'

SELECT @NotExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [Coupon].[DiscountTypeMaster] DestTable
ON  ToInsert.DiscountTypeId = DestTable.DiscountTypeId
WHERE DestTable.DiscountTypeId Is Null


DELETE [Coupon].[DiscountTypeMaster]
FROM #INSERTDATA ToInsert
JOIN [Coupon].[DiscountTypeMaster] DestTable
ON  ToInsert.DiscountTypeId = DestTable.DiscountTypeId

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [Coupon].[DiscountTypeMaster].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [Coupon].[DiscountTypeMaster].'

DROP TABLE #INSERTDATA

GO
