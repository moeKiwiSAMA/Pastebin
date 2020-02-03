# Pastebin

A webapplication allows you copy & paste things between devices.

## Run in docker

Just simply start the container, you can run with port or add [nginx reverse proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) by yourself.

Without Google reCAPTCHA

```bash
docker run -d -p 8080:80 moekiwisama/pastebin:latest
```

With Google reCAPTCHA

```bash
docker run -d -p 8080:80 -e args="--userecaptcha=true --secretkey=your-secretkey --publickey=your-publickey -recaptcharate=0.6" moekiwisama/pastebin:latest
```

## Build by myself

⚠ [Go(=>1.13)](https://github.com/golang/go/wiki/Ubuntu) is [required]. ⚠

```bash
git clone https://github.com/moeKiwiSAMA/Pastebin
cd Pastebin
make
```

## Run by myself

The final binary result exist in bin/pastebin, you should make a dir and put your website(public) with the binary file.

```bash
cp bin/pastebin ./
./pastebin
```

⚠ An [Redis](https://redis.io/) instance is required. ⚠

Pastebin takes some parameters, you can find them with `pastebin --help`

```bash
Usage of ./pastebin:
  -address string
        Pastebin Listen Port (default "0.0.0.0")
  -port string
        Pastebin Bind IP (default "80")
  -publickey string
        Recaptcha site key
  -recaptcharate float
        Recaptcha verify score (default 0.6)
  -redisadd string
        RedisIP (default "127.0.0.1")
  -redisport string
        RedisPort (default "6379")
  -secretkey string
        Recaptcha Secret Key
  -userecaptcha
        Use Google Recaptcha or not
```

And here we go.

```bash
Now listening on: http://0.0.0.0:80
Application started. Press CTRL+C to shut down
```