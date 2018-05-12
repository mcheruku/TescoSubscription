USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Migration Script
** NAME           : Migrate data from [Coupon].[Coupon] table to [Coupon].[Campaign] table.
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : This script will migrate data from [Coupon].[Coupon] table to 
**					[Coupon].[Campaign] table.
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

SELECT @actual = count(Distinct C.CouponID)
FROM [Coupon].[Coupon] C

PRINT 'Coupon(s) expected to be migrated: '+ Convert(varchar(10),@actual)

IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
BEGIN
	
	SELECT @exists = COUNT(1) 
	FROM Coupon.Coupon C
	JOIN [Coupon].[Campaign] DestTable
		ON  C.[CouponID] = DestTable.[CampaignID]

	IF @exists <> 0
	BEGIN
		RAISERROR('Table [Coupon].[Campaign] already has records, kindly remove them after taking backup and run the script again.',15,1)
	END 
	ELSE
	BEGIN

		SET IDENTITY_INSERT [TescoSubscription].[Coupon].[CAMPAIGN] ON

		INSERT INTO [TescoSubscription].[Coupon].[CAMPAIGN]
				   ([CampaignID]
				   ,[CampaignCode]
				   ,[DescriptionShort]
				   ,[DescriptionLong]
				   ,[Amount]
				   ,[IsActive]
				   ,[CampaignTypeID]
				   ,[UTCCreatedDateTime]
				   ,[UTCUpdatedDateTime])
				SELECT 
						C.CouponID
						,C.CouponCode
						,C.DescriptionShort
						,C.DescriptionLong
						,C.Amount
						,C.IsActive
						,1 					--DEFAULT CampaignTypeID POINTING TO UNLINKED CouponS						
						,C.UTCCreatedeDateTime
						,C.UTCUpdatedDateTime
				FROM Coupon.Coupon C						
			LEFT JOIN [Coupon].[Campaign] DestTable
				ON  C.[CouponID] = DestTable.[CampaignID]
				WHERE DestTable.[CampaignID] Is Null	
		
		SET @migrated = @@ROWCOUNT

		UPDATE C SET [CampaignID] = [CouponID]	
		FROM Coupon.Coupon C						
			JOIN [Coupon].[Campaign] DestTable
				ON  C.[CouponCode] = DestTable.[CampaignCode]
		

		SET IDENTITY_INSERT [TescoSubscription].[Coupon].[CAMPAIGN] OFF

		PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[Campaign].'
		PRINT 'MIGRATED - ' + CONVERT(varchar(10), @migrated) + ' record(s) into [Coupon].[Campaign].'
		PRINT 'Migration Completed'	
	END
END
	ELSE
		BEGIN
			PRINT 'NOT EXISTS - Table [Coupon].[Campaign] doesn''t exists.'
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
