
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


