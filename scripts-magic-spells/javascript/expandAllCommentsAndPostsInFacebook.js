// this script will expand all comments and posts on the current page in Facebook paste it in dev tools -> console and press enter then you can now easily use ctrl + f to find/search
/*
 * title: Expand all comments and posts in Facebook
 * date: 2024-02-04-1211 (February 4th, 2024 12:11pm)
 * tags:
 * - JavaScript 
 * description: 
 * this script will expand all comments and posts on the current page in Facebook 
 * paste it in dev tools -> console and press enter 
 * then you can now easily use ctrl + f to find/search
 * */

const DELAY = 500;
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
function str(str) {
  return (str || '').trim().replaceAll(/\s+/g, ' ') || '';
}
function getElementByRegex(root, regex, results = []) {
  const arr = root.children;
  //assume button is on lowest node
  if (arr.length === 0 && regex.test(str(root.innerText)))
    results.push(root);
  for (const child of arr)
    getElementByRegex(child, regex, results);
  return results;
}
function notRedirects(el) {
  //fb can easily break this
  while (el.attributes.length !== 0) {
    if (el.tagName === 'A')
      return false;
    el = el.parentElement
  }
  return true;
}
(async () => {
  await sleep(0);
  const feed = document.querySelector('div[role="feed"]');
  console.log('scrolling...');
  while (str(feed.lastChild.innerText) !== "End of results") {
    feed.lastChild.scrollIntoView();
    await sleep(DELAY);
  }
  console.log('loading top comments...');
  for (const el of getElementByRegex(feed, /^\d+ comments$/)) {
    el.click();
    await sleep(DELAY);
  };
  console.log('loading all comments...');
  {
    let arr;
    do { //for nested comments
      arr = getElementByRegex(feed, /^View (\d+ )?(more|previous) ((comment|answer)s?|(reply|replies))$/);
      for (const el of arr) {
        el.click();
        await sleep(DELAY);
      }
    } while (arr.length !== 0);
  }
  await sleep(DELAY * 5); //ensure all comments are loaded
  console.log('expanding all text...');
  for (const el of getElementByRegex(feed, /^See more$/).filter(notRedirects)) {
    el.click();
  };
  console.log('done');
})();
