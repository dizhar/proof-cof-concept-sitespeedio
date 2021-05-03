require('./proxy');

module.exports = async function(context, commands) {
    context.proxy  =  await '<head>[0]'.proxyReplace('<head><link rel="dns-prefetch" href="https://staging.piecdn.com/5ea5702b896f2df6a1d525ae_stage.js"><script src="https://staging.piecdn.com/5ea5702b896f2df6a1d525ae_stage.js"></script> ', 8888)
};
