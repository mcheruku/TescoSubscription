USE [TescoSubscription]
GO

/*
 Type           : Refrence Data  
 Name           : TABLE [Coupon].[CampaignAttributeReference]   
 Author         : Robin
 Description    : THIS SCRIPT WILL INSERT MASTER DATA IN [Coupon].[CampaignAttributeReference] DATE WRITTEN   : 06/03/2013                     
 */
SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

SELECT @exists = COUNT(1) 
FROM (
SELECT 7 AS [AttributeID],'IsClubCardBoost' AS [Description]
UNION ALL
SELECT 8 AS [AttributeID],'ClubCardVoucherValue' AS [Description]) ToInsert
JOIN [Coupon].[CampaignAttributeReference] DestTable
ON  ToInsert.[AttributeID] = DestTable.[AttributeID]

INSERT INTO [Coupon].[CampaignAttributeReference](
	[AttributeID],
	[Description])
SELECT 
	ToInsert.[AttributeID],
	ToInsert.[Description]
FROM (
SELECT 7 AS [AttributeID],'IsClubCardBoost' AS [Description]
UNION ALL
SELECT 8 AS [AttributeID],'ClubCardVoucherValue' AS [Description]) ToInsert
LEFT JOIN [Coupon].[CampaignAttributeReference] DestTable
ON  ToInsert.[AttributeID] = DestTable.[AttributeID]
WHERE DestTable.[AttributeID] IS NULL

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [Coupon].[CampaignAttributeReference].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [Coupon].[CampaignAttributeReference].'


GO

 


 