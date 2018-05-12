USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : Migration Script
** NAME           : Migrate data from [Coupon].[CampaignAttributes] table planid to 
**					[Coupon].[CampaignPlanDetails] table.
** AUTHOR         : Robin 
** DESCRIPTION    : This script will migrate CampaignID from [Coupon].[CampaignAttributes] table to 
**					[Coupon].[CampaignPlanDetails] table.
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
FROM [Coupon].[CampaignAttributes]
WHERE Attributeid = 1

PRINT 'CampaignID and PlanID expected to be migrated: '+ Convert(varchar(10),@actual)

IF OBJECT_ID(N'[Coupon].[CampaignPlanDetails]',N'U') IS NOT NULL
BEGIN
	
	SELECT @exists = COUNT(1) 
	FROM [Coupon].[CampaignAttributes] ToInsert
	JOIN [Coupon].[CampaignPlanDetails] DestTable
	ON  ToInsert.CampaignID = DestTable.CampaignID
    WHERE ToInsert.Attributeid = 1
			

	IF @exists <> 0
	BEGIN
		RAISERROR('Table [Coupon].[CampaignPlanDetails] already has records, kindly remove them after taking backup and run the script again.',15,1)
	END 
	ELSE
	BEGIN	

		INSERT INTO [Coupon].[CampaignPlanDetails]([CampaignID],[SubscriptionPlanID])
		SELECT ToInsert.CampaignID,ToInsert.AttributeValue FROM [Coupon].[CampaignAttributes] ToInsert
		LEFT JOIN [Coupon].[CampaignPlanDetails] DestTable
		ON  ToInsert.CampaignID = DestTable.CampaignID
        WHERE DestTable.CampaignID IS NULL
        AND ToInsert.AttributeID = 1
				
		
		SET @migrated = @@ROWCOUNT

	
		PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[CampaignPlanDetails].'
		PRINT 'MIGRATED - ' + CONVERT(varchar(10), @migrated) + ' record(s) into [Coupon].[CampaignPlanDetails].'
		PRINT 'Migration Completed'	
	END
END
	ELSE
		BEGIN
			PRINT 'NOT EXISTS - Table [Coupon].[CampaignPlanDetails] doesn''t exists.'
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
