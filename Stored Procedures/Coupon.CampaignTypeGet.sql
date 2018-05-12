USE [TescoSubscription]
GO

IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignTypeGet]

		IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignTypeGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignTypeGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignTypeGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [TescoSubscription].[CampaignTypeGet]
** DATE WRITTEN   : 06/04/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): DATA OF TABLE [Coupon].[CampaignTypeGet] WHICH IS ACTIVE
*******************************************************************************************  
*******************************************************************************************/

CREATE PROCEDURE [Coupon].[CampaignTypeGet]
AS


BEGIN

	SET NOCOUNT ON;	

	SELECT 
		CampaignTypeID as [CampaignTypeId],
		CampaignTypeName as [CampaignTypeName],
		Description
	FROM [Coupon].[CampaignTypeMaster]
	WHERE IsActive = 1 --Active Campaign
	--FOR XML PATH('SubscriptionCouponType'),TYPE,root('SubscriptionCouponTypes')

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignTypeGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignTypeGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignTypeGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignTypeGet] not created.',16,1)
	END
GO