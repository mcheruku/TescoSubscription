USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Migration Script
** NAME           : Migrate data from [Coupon].[CouponAttributes] table to 
**					[Coupon].[CampaignAttributes] table.
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : This script will migrate data from [Coupon].[CouponAttributes] table to 
**					[Coupon].[CampaignAttributes] table.
** DATE WRITTEN   : 06/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
*******************************************************************************************/
SET NOCOUNT ON
GO

BEGIN TRY

DECLARE @migrated INT, @exists INT, @actual INT

SELECT @migrated = 0, @exists = 0, @actual = 0

SELECT @actual = count(*)
FROM [Coupon].[CouponAttributes] CA

PRINT 'Coupon(s) Attributes expected to be migrated: '+ Convert(varchar(10),@actual)

IF OBJECT_ID(N'[Coupon].[CampaignAttributes]',N'U') IS NOT NULL
BEGIN
	
	SELECT @exists = COUNT(1) 
	FROM [Coupon].[CouponAttributes] ToInsert
	JOIN [Coupon].[CampaignAttributes] DestTable
		ON  ToInsert.CouponID = DestTable.CampaignID
			AND ToInsert.AttributeID = DestTable.AttributeID

	IF @exists <> 0
	BEGIN
		RAISERROR('Table [Coupon].[CampaignAttributes] already has records, kindly remove them after taking backup and run the script again.',15,1)
	END 
	ELSE
	BEGIN	

		INSERT INTO [Coupon].[CampaignAttributes]
		SELECT ToInsert.* FROM [Coupon].[CouponAttributes] ToInsert
		LEFT JOIN [Coupon].[CampaignAttributes] DestTable
			ON  ToInsert.CouponID = DestTable.CampaignID
				AND ToInsert.AttributeID = DestTable.AttributeID
			WHERE DestTable.AttributeID Is Null
				AND DestTable.CampaignID Is Null	
		
		SET @migrated = @@ROWCOUNT

	
		PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[CampaignAttributes].'
		PRINT 'MIGRATED - ' + CONVERT(varchar(10), @migrated) + ' record(s) into [Coupon].[CampaignAttributes].'
		PRINT 'Migration Completed'	
	END
END
	ELSE
		BEGIN
			PRINT 'NOT EXISTS - Table [Coupon].[CampaignAttributes] doesn''t exists.'
		END

/* Inserting AttributeID 6 */

SELECT @migrated = 0, @exists = 0, @actual = 0

--Finding CampaignID(s) which need to be fixed and saving them in #CampaingnIDToFix table
SELECT * INTO #CampaingnIDToFix from (
SELECT DISTINCT CampaignID FROM Coupon.CampaignAttributes CAO 
WHERE NOT EXISTS
				(SELECT 1 from Coupon.CampaignAttributes CAI 
				WHERE CAI.CampaignID = CAO.CampaignID
				AND CAI.AttributeID = 6)
				)Temp

SELECT @actual = count(*) FROM #CampaingnIDToFix

PRINT 'Campaign AttributeId(s) expected to be upgraded to support AttributeID 6: '+ Convert(varchar(10),@actual)

IF OBJECT_ID(N'[Coupon].[CampaignAttributes]',N'U') IS NOT NULL
BEGIN
	
	--Find CampaingnID(s) which already have AttributeID 6 installed for them in [Coupon].[CampaignAttributes] table.
	SELECT @exists=COUNT(DISTINCT TempB.CampaignID)
	FROM [Coupon].[CampaignAttributes] TempA
	INNER JOIN [Coupon].[CampaignAttributes] TempB
		ON  TempA.CampaignID = TempB.CampaignID
		AND TempB.AttributeId = 6
	
	IF @exists <> 0
	BEGIN
		DROP TABLE #CampaingnIDToFix
		PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' fixed record(s) already exist in [Coupon].[CampaignAttributes].'
		RAISERROR('Table [Coupon].[CampaignAttributes] already has few fixed records, kindly remove them after taking backup and run the script again.',15,1)
	END 
	ELSE
	BEGIN	

	--Fixing the CampaignID(s)
	INSERT INTO [TescoSubscription].[Coupon].[CampaignAttributes]
	           ([CampaignID]
	           ,[AttributeID]
	           ,[AttributeValue])
		 SELECT DISTINCT ToInsert.CampaignID
				,6 AS [AttributeID]
				,1 AS [AttributeValue]		--Default Value for CouponsGeneratedCount for existing Coupons in system					
		FROM #CampaingnIDToFix ToInsert
		LEFT JOIN [Coupon].[CampaignAttributes] DestTable
			ON ToInsert.CampaignID = DestTable.CampaignID
		WHERE DestTable.CampaignID IS NOT NULL		
		
		SET @migrated = @@ROWCOUNT

		PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' such record(s) already exist in [Coupon].[CampaignAttributes].'
		PRINT 'UPGRADED - ' + CONVERT(varchar(10), @migrated) + ' record(s) in [Coupon].[CampaignAttributes].'
		PRINT 'UPGRADE Completed'	

		DROP TABLE #CampaingnIDToFix
	END
END
	ELSE
		BEGIN
			PRINT 'NOT EXISTS - Table [Coupon].[CampaignAttributes] doesn''t exists.'
		END


END TRY

BEGIN CATCH
		SELECT 
		ERROR_NUMBER()																AS ERRORNUMBER,
		ERROR_SEVERITY()															AS ERRORSEVERITY,
		ERROR_STATE()																AS ERRORSTATE,
		ERROR_LINE()																AS ERRORLINE,
		ERROR_MESSAGE()																AS ERRORMESSAGE;			
		
		PRINT 'An error has occurred while migrating the data: '+ERROR_MESSAGE()
END CATCH;
