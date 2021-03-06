USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[UnredeemedCouponGet]

		IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[UnredeemedCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[UnredeemedCouponGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[UnredeemedCouponGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[UnredeemedCouponGet]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : Coupon(s) which aren't redeemed
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[UnredeemedCouponGet] 
(
@CampaignID				BIGINT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @ErrorMessage			NVARCHAR(2048)
	DECLARE @CampaignTypeID			INT
	
BEGIN TRY

	SELECT @CampaignTypeID = C.CampaignTypeID 
	FROM
		Coupon.Campaign C
	WHERE C.CampaignID = @CampaignID 
	
	IF (@@ROWCOUNT  = 0)
		BEGIN
			SET @ErrorMessage = 'Unable to Determine CampaignTypeID for the supplied CampaignID'
					
			RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
		END
	ELSE
		BEGIN		
			SELECT 
				C.CouponCode, 
				CCM.CustomerID 
			FROM Coupon.Coupon C (NOLOCK)  
				INNER JOIN Coupon.CouponCustomerMap CCM (NOLOCK)
				ON C.CouponID = CCM.CouponID
			WHERE C.CampaignID = @CampaignID 
			AND NOT EXISTS (SELECT 1 FROM Coupon.CouponRedemption Cr (NOLOCK)
							WHERE C.CouponCode = Cr.CouponCode) 								
	END
	
	END TRY
	BEGIN CATCH
	SET @ErrorMessage = ERROR_MESSAGE()
	
	IF OBJECT_ID('tempdb..#CustomerLinkedCoupons') IS NOT NULL DROP TABLE #CustomerLinkedCoupons									
		
			RAISERROR (
					'SP - [coupon].[UnredeemedCouponGet] Error = (%s)',
					16,
					1,
					@ErrorMessage
					)			
	END CATCH
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[UnredeemedCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[UnredeemedCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[UnredeemedCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[UnredeemedCouponGet] not created.',16,1)
	END
GO
	

