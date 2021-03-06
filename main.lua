-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local IAP = require("IAP");
IAP:init();


local widget = require("widget");
menuHeight = 50;
iosPadding = 20;

console = native.newTextBox(0,menuHeight+iosPadding,display.contentWidth,display.contentHeight-iosPadding-menuHeight);
console.anchorX=0; console.anchorY=0;
console.isEditable = false;
console.hasBackground = false;
console:setTextColor( 0.9, 0.9, 0.9 );

local logs = "";
function console:log(text)
	logs = logs..tostring(text).."\n";
	console.text = logs;
end

-- Function to handle button events
local function onBuyClicked( event )
    if ( "ended" == event.phase ) then
		if system.getInfo("environment")=="simulator" then
			print("IAP testing is not supported in the simulator");
			return;
		end;

        IAP:purchase(IAP.products[1], function(errorString)
			console:log("\nPURCHASE CALLBACK: \n");
			if not errorString then
				for i=1,#IAP.products do
					local product = IAP.products[i];
					console:log(product.productIdentifier);
					console:log("Title: "..tostring(product.title));
					console:log("Description: "..tostring(product.description));
					console:log("Localized price: "..tostring(product.localizedPrice));
					console:log("Currency: "..tostring(product.priceCurrencyCode));
					console:log("Is owned: "..tostring(product.isOwned));
					console:log("----------------------");
				end
			else
				console:log(tostring(errorString));
			end
		end);
    end
end

local function onConsumeClicked( event )
    if ( "ended" == event.phase ) then
		if system.getInfo("environment")=="simulator" then
			print("IAP testing is not supported in the simulator");
			return;
		end;

        IAP:consume(IAP.products[1], function(errorString)
			console:log("\nCONSUME CALLBACK: \n");
			if not errorString then
				for i=1,#IAP.products do
					local product = IAP.products[i];
					console:log(product.productIdentifier);
					console:log("Title: "..tostring(product.title));
					console:log("Description: "..tostring(product.description));
					console:log("Localized price: "..tostring(product.localizedPrice));
					console:log("Currency: "..tostring(product.priceCurrencyCode));
					console:log("Is owned: "..tostring(product.isOwned));
					console:log("----------------------");
				end
			else
				console:log(tostring(errorString));
			end
		end);
    end
end

local buyButton = widget.newButton(
    {
        left = 0,
        top = iosPadding,
		width = menuHeight*2,
		height = menuHeight,
        id = "buy",
        label = "BUY",
        onEvent = onBuyClicked
    }
)

local consumeButton = widget.newButton(
    {
        left = display.contentWidth-menuHeight*2,
        top = iosPadding,
		width = menuHeight*2,
		height = menuHeight,
        id = "consume",
        label = "CONSUME",
        onEvent = onConsumeClicked
    }
)

-- await until products are loaded
timer.performWithDelay(1000, function()
	if system.getInfo("environment")=="simulator" then
		print("IAP testing is not supported in the simulator");
		return;
	end;

	console:log("\n LOADED PRODUCTS: \n");
	for i=1,#IAP.products do
		local product = IAP.products[i];
		console:log(product.productIdentifier);
		console:log("Title: "..tostring(product.title));
		console:log("Description: "..tostring(product.description));
		console:log("Localized price: "..tostring(product.localizedPrice));
		console:log("Currency: "..tostring(product.priceCurrencyCode));
		console:log("Is owned: "..tostring(product.isOwned));
		console:log("----------------------");
	end
end, 1 );
