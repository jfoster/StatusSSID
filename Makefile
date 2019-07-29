export DEBUG = 1
export FOR_RELEASE = 0

include $(THEOS)/makefiles/common.mk

SUBPROJECTS = springboard uikit

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
