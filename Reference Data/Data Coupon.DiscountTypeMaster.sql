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

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [Coupon].[DiscountTypeMaster] DestTable
ON  ToInsert.DiscountTypeId = DestTable.DiscountTypeId

INSERT INTO [Coupon].[DiscountTypeMaster](
	DiscountTypeId,
	DiscountName,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.DiscountTypeId,
	ToInsert.DiscountName,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [Coupon].[DiscountTypeMaster] DestTable
ON  ToInsert.DiscountTypeId = DestTable.DiscountTypeId
WHERE DestTable.DiscountTypeId Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[DiscountTypeMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[DiscountTypeMaster].'

DROP TABLE #INSERTDATA

GO
