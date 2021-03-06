USE [TescoSubscription]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]
( 
	@CustomerId BIGINT
)
AS
BEGIN
SET NOCOUNT ON;

	SELECT [CustomerSubscriptionId]
          ,[PaymentRemainingAmount] 
      FROM [tescosubscription].[CustomerPaymentRemainingDetail] WITH (NOLOCK)
      WHERE [CustomerSubscriptionId] = @CustomerId
END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerRemainingPaymentAfterCouponDiscountGet] not created.',16,1)
	END
GO
