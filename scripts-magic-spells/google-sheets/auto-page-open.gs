// HOW TO USE:
// 1. On a google sheets document, navigate to Extensions -> Apps Script
// 2. Paste the following code in the code.gs file (should be the first file seen). Then save
// 3. Now to use it, click any cell on the row of the website that you want to open up all the pages for.
// 4. Then on the top menu of the sheets ui, there should be a newly made menu called "Open Website Details", click on that then "Open Lead Info"
// 5. A bare bones html list of the links to all the websites should then open up on ride side, middle click all of them to open them in a new tab.
// 
// ASSUMTIONS:
// - The original source website links are in the A column (feel free to change that if you like)
// - The business name is the domain name minus any subdomain or the TLD. For example: www.google.ca => google
//
// FROM: https://github.com/Show-The-World/Google-Sheets-Scripts/blob/main/Auto_Page_Open.gs
// SEE IN ACTION (VIDEO): https://www.loom.com/share/fb47bb06632d4081b2aa6d761c268ead?sid=5291627a-f85d-464c-9662-5a8240cd68c3



function  onOpen() {
  var ui = SpreadsheetApp.getUi();
  // Create a custom menu called "Open Websites"
  ui.createMenu('Open Website Details')
      .addItem('Open Lead Info', 'openLeadInfo')
      .addToUi();
}

function openLeadInfo() {
  // Gets access to current sheet
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var row = sheet.getActiveRange().getRow();
  // Gets the website's cell location (on the sheets). This value corresponds to the cell that was selected when initializing the function
  var websiteCell = sheet.getRange(`A${row}`).getValue(); // Assuming websites are in column A

  // Estimates the businesses name based on the domain (sometime the business name won't align with the ideal business name you may want to search for)
  var estimatedBusinessName = websiteCell.replace(/^https?:\/\/(www\.)?|\/.*$|\.[^\.]+$/g, '');
  
  var urls = [
    websiteCell,
    `https://developers.google.com/speed/pagespeed/insights/?url=${encodeURIComponent(websiteCell)}`,
    `https://builtwith.com/?${encodeURIComponent(websiteCell)}`,
    `https://www.google.com/search?q=${estimatedBusinessName}`,
    // ... any other URLs you need
  ];

  // Store URLs in the user's properties
  PropertiesService.getUserProperties().setProperty('urls', JSON.stringify(urls));

  // Show sidebar with links
  var htmlOutput = HtmlService.createHtmlOutput('<ul>' +
    urls.map(function(url) {
      return `<li><a href="${url}" target="_blank" onclick="google.script.host.close()">${url}</a></li>`;
    }).join('') +
    '</ul>')
    .setTitle('Open Client Info')
    .setWidth(300);
  SpreadsheetApp.getUi().showSidebar(htmlOutput);
}
