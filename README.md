# Kit argument demo

Shows how to use a different base image for a kit build, for example one image in CI and another for local testing.

How it works: `--kit-arg base=...` sets `BASE_IMAGE` in the Dockerfile, which sets the `FROM` image.

The kit builds from `debian:trixie-slim` by default. The test below overrides it with `debian:bookworm-slim`.

## Try it

Run these from the folder that contains `kit-arg-demo/`:

```bash
# Default base image (Debian 13)
sbx create --name kitarg-default ./kit-arg-demo .
sbx exec kitarg-default cat /home/agent/kit-base-version

# Overridden base image (Debian 12)
sbx create --name kitarg-override --kit-arg base=debian:bookworm-slim ./kit-arg-demo .
sbx exec kitarg-override cat /home/agent/kit-base-version

# Clean up
sbx rm kitarg-default kitarg-override
```

The first `cat` prints `13.x` and the second prints `12.x`.

If the second command fails with `no kit declares this argument`, update sbx and try again.
