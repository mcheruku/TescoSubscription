USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponDetailsGet3]
    
    IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet3] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponDetailsGet3] not dropped.',
            16,
            1
        )
    END
END

GO
CREATE PROCEDURE [Coupon].[CouponDetailsGet3]
(
	@CouponCode				NVARCHAR(200)
)
AS
/*
	Author:		Robin
	Created:	17/Feb/2014
	Purpose:	Get coupon based on couponCode

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/
BEGIN

	SET NOCOUNT ON;	
DECLARE

@Delimiter    NVARCHAR(1)

SET @Delimiter = ','

DECLARE 
@CouponTable  TABLE (String NVARCHAR(44))


INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))

SELECT 
		CC.CouponCode,
        CC.CouponID,
		CM.DescriptionShort,
		CM.DescriptionLong,
		CC.RedeemCount,
		CM.IsActive,
        CM.campaignTypeID CouponType,
        DM.DiscountTypeId,
        DT.Discountvalue,
        DM.DiscountName       
        FROM Coupon.Coupon CC WITH (NOLOCK)
        INNER JOIN Coupon.Campaign CM WITH (NOLOCK)
        ON CC.CampaignID = CM.CampaignID
        INNER JOIN Coupon.CampaignDiscountType DT WITH (NOLOCK)
        ON CM.CampaignID = DT.CampaignID
        INNER JOIN Coupon.DiscountTypeMaster DM WITH (NOLOCK) 
        ON DT.DiscountTypeID = DM.DiscountTypeID
        WHERE  CC.CouponCode  IN (SELECT String FROM @CouponTable)

-- In case of Linked Coupon

SELECT CC.CouponCode,
       CM.CustomerID
       FROM Coupon.Coupon CC WITH (NOLOCK)
       INNER JOIN Coupon.CouponCustomerMap CM WITH (NOLOCK)
       ON CC.CouponID = CM.CouponID
       Where CC.CouponCode IN (SELECT String FROM @CouponTable)     

END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponDetailsGet3] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponDetailsGet3]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponDetailsGet3] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponDetailsGet3] not created.',
        16,
        1
    )
END
GO



