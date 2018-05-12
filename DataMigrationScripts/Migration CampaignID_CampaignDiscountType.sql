USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Migration Script
** NAME           : Migrate data from [Coupon].[Campaign] table to 
**					[Coupon].[CampaignDiscountType] table.
** AUTHOR         : Robin 
** DESCRIPTION    : This script will migrate CampaignID from [Coupon].[Campaign] table to 
**					[Coupon].[CampaignDiscountType] table.
** DATE WRITTEN   : 18/02/2014
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
FROM [Coupon].[Campaign] CA

PRINT 'CampaignID expected to be migrated: '+ Convert(varchar(10),@actual)

IF OBJECT_ID(N'[Coupon].[CampaignDiscountType]',N'U') IS NOT NULL
BEGIN
	
	SELECT @exists = COUNT(1) 
	FROM [Coupon].[Campaign] ToInsert
	JOIN [Coupon].[CampaignDiscountType] DestTable
		ON  ToInsert.CampaignID = DestTable.CampaignID
			

	IF @exists <> 0
	BEGIN
		RAISERROR('Table [Coupon].[CampaignDiscountType] already has records, kindly remove them after taking backup and run the script again.',15,1)
	END 
	ELSE
	BEGIN	

		INSERT INTO [Coupon].[CampaignDiscountType](CampaignID,DiscountTypeID,DiscountValue)
		SELECT ToInsert.CampaignID,'1',CAST(ToInsert.Amount AS decimal(6,2)) FROM [Coupon].[Campaign] ToInsert
		LEFT JOIN [Coupon].[CampaignDiscountType] DestTable
		ON  ToInsert.CampaignID = DestTable.CampaignID
        WHERE DestTable.CampaignID IS NULL
		
		SET @migrated = @@ROWCOUNT

	
		PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[CampaignDiscountType].'
		PRINT 'MIGRATED - ' + CONVERT(varchar(10), @migrated) + ' record(s) into [Coupon].[CampaignDiscountType].'
		PRINT 'Migration Completed'	
	END
END
	ELSE
		BEGIN
			PRINT 'NOT EXISTS - Table [Coupon].[CampaignDiscountType] doesn''t exists.'
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


 