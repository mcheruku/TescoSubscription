IF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponDetailsGet]

		IF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet] not dropped.',16,1)
			END
	END
GO





CREATE PROCEDURE [Coupon].[CouponDetailsGet]
(
	@CouponCode				NVARCHAR(25)	
)
AS


/*
	Author:		Shilpa
	Created:	18/Sep/2012
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN

	SET NOCOUNT ON;	

	SELECT 
		CouponCode,
		DescriptionShort,
		DescriptionLong,
		Amount,
		RedeemCount,
		IsActive	
	FROM
		Coupon.Coupon c (NOLOCK)
	WHERE
		CouponCode = @CouponCode


	SELECT 
		ca.AttributeId,
		ca.AttributeValue
	FROM
		Coupon.Coupon c (NOLOCK)
	INNER JOIN 
		Coupon.CouponAttributes ca (NOLOCK)
	ON c.CouponID = ca.CouponID
	WHERE
		CouponCode = @CouponCode
	ORDER BY ca.AttributeId

END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponDetailsGet] not created.',16,1)
	END
GO
