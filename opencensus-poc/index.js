const tracing = require('@opencensus/nodejs');
const { globalStats } = require('@opencensus/core');
const { JaegerTraceExporter } = require('@opencensus/exporter-jaeger');
const { PrometheusStatsExporter } = require('@opencensus/exporter-prometheus');

const options = {
  serviceName: 'my-service',
  tags: [], // optional
  host: 'localhost', // optional
  port: 6832, // optional
  maxPacketSize: 65000 // optional
}
const exporter = new JaegerTraceExporter(options);
const rootSpanOptions = { name: 'your root span' };
tracing.start({'exporter': exporter});
tracing.tracer.startRootSpan(rootSpanOptions, (rootSpan) => {



// Add your port and startServer to the Prometheus options
const prometheusExporter = new PrometheusStatsExporter({
  port: 9090,
  startServer: true
});
globalStats.registerExporter(prometheusExporter);

 
 // You can create as many child spans as needed
 childSpan = tracing.tracer.startChildSpan({
        name: 'name of your child span'
    });
    // Do some operation...
    // Finish the child span at the end of it's operation
    childSpan.end();
 
    // Finish the root span at the end of the operation
    rootSpan.end();
});


