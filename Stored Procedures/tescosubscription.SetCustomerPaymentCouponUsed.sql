USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SetCustomerPaymentCouponUsed]

		IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] not dropped.',16,1)
			END
	END
GO 

CREATE PROCEDURE [tescosubscription].[SetCustomerPaymentCouponUsed] 
(
 @CustomerID     BIGINT
 ,@CouponCodes    VARCHAR(MAX)
)
 AS 
 /*   
 Author:   Deepmala Trivedi 
 Date created: 23 Apr 2014 
 Purpose:  To update the customer's payment coupon status  
 Behaviour:  How does this procedure actually work  
 Usage:   Hourly/Often 
 Called by:  <SubscriptionService>  
 WarmUP Script: Execute [BOASubscription].[CountryCurrencyGet] 

 --Modifications History--  
 Changed On   Changed By  Defect Ref  Change Description  23/0
 4/2014        Deepmala    CREATE PROCEDURE  
 20 Aug 2014   Robin       Added Update statement for UTCUpdatedDateTime
 */ 

BEGIN 

SET NOCOUNT ON 
 
    UPDATE CP  
    SET IsActive = 0,
    IsFirstPaymentDue = 0,
	UTCUpdatedDateTime = GETUTCDATE()
    FROM Tescosubscription.CustomerPayment  CP WITH (NOLOCK) 
    JOIN dbo.ConvertListToTable(@CouponCodes,',') CC   
    ON CC.Item = CP.PaymentToken 
    WHERE CustomerId = @CustomerID 

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SetCustomerPaymentCouponUsed] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[SetCustomerPaymentCouponUsed]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[SetCustomerPaymentCouponUsed] not created.',16,1)
	END
GO
    