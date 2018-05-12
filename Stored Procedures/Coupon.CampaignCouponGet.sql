USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCouponGet]

		IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCouponGet] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCouponGet]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCouponGet]
** DATE WRITTEN   : 25/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignCouponGet] 
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
			IF (@CampaignTypeID = 1 OR @CampaignTypeID = 2)--Naive or Unique Coupons
				BEGIN

					SELECT Cpn.CouponCode
						FROM Coupon.Coupon Cpn
						WHERE Cpn.CampaignID = @CampaignID
					
				END
			ELSE IF(@CampaignTypeID = 3)
				BEGIN
					--Getting the list of CustomerID with linked Coupon Code
					SELECT Cm.CustomerID
							,Cpn.CouponCode
						FROM Coupon.Coupon Cpn
						INNER JOIN Coupon.CouponCustomerMap Cm
							ON Cm.CouponID = Cpn.CouponID
							AND Cpn.CampaignID = @CampaignID

				END
			END
		END TRY
		BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()
				
				RAISERROR (
						'SP - [coupon].[CampaignCouponGet] Error = (%s)',
						16,
						1,
						@ErrorMessage
						)			
		END CATCH
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCouponGet] not created.',16,1)
	END
GO
	

