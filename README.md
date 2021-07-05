
# Auto purchase item(s) based on the count of another item

I didn't find addons do the job, so wrote one.

Supported input string following

`ItemName1:/3;ItemName2:*2;ItemName3:*3`

The example stands for the following

`N = int(Count(ItemName1)/3)`

`Purchase ItemName2, count N*2`

`Purchase ItemName3, count N*3`

Create a new macro in the game with the following content,

`/LSAutoPurchaseTBC ItemName1:/3;ItemName2:*2;ItemName3:*3`

# Use case

My character learned tailoring enchanting, I usually buy clothes from auction, craft and disenchant. I am tried of calcuting the number of bolts in my bag and buy the right number of other martrials from merchant.

`/LSAutoPurchaseTBC Bolt of Silk Cloth:/3;Blue Dye:*2;Fine Thread:*2`

The above macro can purchase the right number of blue dyes and fine threads from merchant.

Run the macro anytime, it checks the numbers.

![image info](./Images/1.png)

Talk to a merchant, and run the macro again, if the merchant has right items, the macro will do the purchase.

![image info](./Images/2.png)
