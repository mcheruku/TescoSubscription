USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Migration Script
** NAME           : Migrate data from [Coupon].[CouponAttributesReference] table to 
**					[Coupon].[CampaignAttributeReference] table.
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : This script will migrate data from [Coupon].[CouponAttributesReference] table to 
**					[Coupon].[CampaignAttributeReference] table.
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

SELECT @actual = count(Distinct CAR.AttributeID)
FROM [Coupon].[CouponAttributesReference] CAR

PRINT 'Coupon(s) Attribute Reference expected to be migrated: '+ Convert(varchar(10),@actual)

IF OBJECT_ID(N'[Coupon].[CampaignAttributeReference]',N'U') IS NOT NULL
BEGIN
	
	SELECT @exists = COUNT(1) 
	FROM [Coupon].[CouponAttributesReference] ToInsert
	JOIN [Coupon].[CampaignAttributeReference] DestTable
		ON  ToInsert.AttributeID = DestTable.AttributeID
	
	IF @exists <> 0
	BEGIN
		RAISERROR('Table [Coupon].[CampaignAttributeReference] already has records, kindly remove them after taking backup and run the script again.',15,1)
	END 
	ELSE
	BEGIN

		INSERT INTO [Coupon].[CampaignAttributeReference]
		SELECT ToInsert.* FROM [Coupon].[CouponAttributesReference] ToInsert
		LEFT JOIN [Coupon].[CampaignAttributeReference] DestTable
			ON  ToInsert.AttributeID = DestTable.AttributeID
			WHERE DestTable.AttributeID Is Null	
		
		SET @migrated = @@ROWCOUNT

		SET IDENTITY_INSERT [TescoSubscription].[Coupon].[CAMPAIGN] OFF

		PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[CampaignAttributeReference].'
		PRINT 'MIGRATED - ' + CONVERT(varchar(10), @migrated) + ' record(s) into [Coupon].[CampaignAttributeReference].'
		PRINT 'Migration Completed'	
	END
END
	ELSE
		BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[CampaignAttributeReference] doesn''t exists.'
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
