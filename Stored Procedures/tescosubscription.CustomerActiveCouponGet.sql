USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerActiveCouponGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerActiveCouponGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerActiveCouponGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveCouponGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveCouponGet] not dropped.',16,1)
			END
	END
GO  
  
CREATE PROCEDURE [tescosubscription].[CustomerActiveCouponGet]  
(  
 @CustomerID BIGINT  
)  
AS
/*
	Author:		Robin
	Created:	17/April/2014
	Purpose:	Get PaymentToken(coupon) and Plan Amount Based on CustomerID 

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/ 
BEGIN  
DECLARE @Active TINYINT
, @Suspended TINYINT

SET  @Active = 8
SET  @Suspended = 7

	 SET NOCOUNT ON  
	  
	 SELECT PaymentToken  
	 FROM TescoSubscription.CustomerPayment WITH (NOLOCK)  
	 WHERE CustomerID = @CustomerID AND IsActive = 1 AND IsFirstPaymentdue=1 AND PaymentModeID=2  
	   
	 SELECT PlanAmount FROM Tescosubscription.SubscriptionPlan SP WITH (NOLOCK)   
	 WHERE SP.SubscriptionPlanID IN (SELECT COALESCE(SwitchTo,SubscriptionPlanID) 
	 FROM TescoSubscription.CustomerSubscription   
	 WHERE CustomerId = @CustomerID AND SubscriptionStatus in (@Active,@Suspended) 
	 )  
  
END  




GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerActiveCouponGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerActiveCouponGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerActiveCouponGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerActiveCouponGet] not created.',16,1)
	END
GO